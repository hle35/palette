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
    local results  ; 
    -- ecriture d'un fichier .IMI
    local imifilename = "/tmpimi/IMItmp002.imi"
    local imiinput    = assert(io.open (imifilename, "w"))
    imiinput:write ("Hello imi" .. "\n")
    imiinput:close ()

    -- Essai d'ajouter une commande de lancement d'imitator
    local imipathname = "/home/cosy/cosy/imitatorstub/imitatorstub"
    local imioptions = " 654 -mode inversemethod -output-result -output-states -output-cart -output-trace-set"
    --local command = [[ ls / ]] 
    local command = [[ {{{imipathname}}} {{{imifilename}}} {{{imioptions}}} ]] % {
        imipathname = imipathname,
        imifilename = imifilename,
        imioptions = imioptions,
    }
    ------- print ("The command:", command)
    local stdout = os.tmpname ()
    local stderr = os.tmpname ()
    assert (scheduler.execute (command, {
      stdout = stdout,
      stderr = stderr,
    }))
    local output = io.open (stdout, "r")
    results = output:read "*all"
    print ("The result:", results)
    output:close ()
    os.remove (stdout  )
    os.remove (stderr  )
    --model.nb_vertices = results [1]
    --model.nb_edges    = results [2]
    -- print ("#vertices:", results [1])
    -- print ("#edges   :", results [2])
    print ("version 0.1.2")
  end

  return graphinfo

end
