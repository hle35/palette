return function (Layer, graphinfo, ref)

  local meta    = Layer.key.meta
  local refines = Layer.key.refines
  local tool    = Layer.require "cosy/formalism/tool"
  local graph   = Layer.require "cosy/formalism/graph"

  graphinfo [refines] = {
    tool
  }

  graphinfo.description = "Computes #vertices and #edges of a graph."

  graphinfo.graph = {
    [refines]   = { ref [meta].parameter_type },
    name        = "graph",
    description = "graph to analyze",
    default     = nil,
    type        = graph,
    update      = true,
  }

  graphinfo.run = function (options)
    local scheduler = options.scheduler
    local model     = options.model.graph
    local results   = {}
    for i, container in ipairs { model.vertices, model.edges } do
      local filename = os.tmpname ()
      local input    = io.open (filename, "w")
      for key in pairs (container) do
        input:write (key .. "\n")
      end
      input:close ()
      local stdout = os.tmpname ()
      local stderr = os.tmpname ()
      local command = [[ wc -l {{{filename}}} ]] % {
        filename = filename,
      }
      assert (scheduler.execute (command, {
        stdout = stdout,
        stderr = stderr,
      }))
      local output = io.open (stdout, "r")
      results [i] = output:read "*all":match "%d+"
      output:close ()
      os.remove (filename)
      os.remove (stdout  )
      os.remove (stderr  )
    end
    model.nb_vertices = results [1]
    model.nb_edges    = results [2]
    print ("#vertices:", results [1])
    print ("#edges   :", results [2])
  end

  return graphinfo

end
