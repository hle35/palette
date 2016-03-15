return function (Layer, palette, ref)

  local meta    = Layer.key.meta
  local refines = Layer.key.refines
  local tool    = Layer.require "cosy/formalism/tool"
  local graph   = Layer.require "cosy/formalism/graph"

  palette [refines] = {
    tool
  }

  palette.description = "Computes #vertices and #edges of a graph."

  palette.graph = {
    [refines]   = { ref [meta].parameter_type },
    name        = "graph",
    description = "graph to analyze",
    default     = nil,
    type        = graph,
    update      = true,
  }

  palette.run = function (options)
    local model = options.model.graph
    model.nb_vertices = 0
    model.nb_edges    = 0
    for key, value in pairs (model [meta]) do
      print ("#key:", key)
      print ("#value:", value)
    end
    for _ in pairs (model.vertices) do
      model.nb_vertices = model.nb_vertices+1
    end
    for _ in pairs (model.edges) do
      model.nb_edges = model.nb_edges+1
    end
    print ("#vertices:", model.nb_vertices)
    print ("#edges   :", model.nb_edges   )
  end

  return palette

end
