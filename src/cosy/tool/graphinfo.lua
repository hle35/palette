return function (Layer)

  local labels  = Layer.key.labels
  local meta    = Layer.key.meta
  local refines = Layer.key.refines
  local tool    = Layer.require "cosy/formalism/tool"
  local graph   = Layer.require "cosy/formalism/graph"

  local graphinfo = Layer.new {
    name = "cosy/tool/graphinfo",
  }

  graphinfo [labels] = {
    ["cosy/tool/graphinfo"] = true
  }
  local _ = Layer.reference "cosy/tool/graphinfo"

  graphinfo [refines] = {
    tool
  }

  graphinfo.description = "Computes #vertices and #edges of a graph."

  graphinfo.graph = {
    [refines]   = { _ [meta].parameter_type },
    name        = "graph",
    description = "graph to analyze",
    default     = nil,
    type        = graph,
  }

  graphinfo.run = function (options)
    local model = options.model.graph
    model.nb_vertices = 0
    model.nb_edges    = 0
    for _ in pairs (model.vertices) do
      model.nb_vertices = model.nb_vertices+1
    end
    for _ in pairs (model.edges) do
      model.nb_edges = model.nb_edges+1
    end
    print ("#vertices:", model.nb_vertices)
    print ("#edges   :", model.nb_edges   )
  end

  return graphinfo

end
