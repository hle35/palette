return function (Layer, optionsdisplay, ref)

--   This version is a draft example to test the command line options :
-- cosy-tool cosy/tool/optionsdisplay  --graph=cosy/tool/graphinfo-test --depth_limit=10 --states_limit=1000 --time_limit=100
--   Note: the "key" field of options is automatically generated from "name" field (eg to suppress spaces)


  local meta    = Layer.key.meta
  local refines = Layer.key.refines
  local tool    = Layer.require "cosy/formalism/tool"
  local graph   = Layer.require "cosy/formalism/graph"

  optionsdisplay [refines] = {
    tool
  }

  optionsdisplay.description = "Computes #vertices and #edges of a graph."

  optionsdisplay.options = {
    graph = {
      [refines]   = { ref [meta].parameter_type },
      name        = "graph",
      description = "graph to analyze",
      default     = nil,
      type        = graph,
      update      = true,
    },
    depth_limit = {  -- nouvelle option
      [refines]   = { ref [meta].parameter_type },
      name        = "depth_limit", -- "Depth limit" "depth-limit"
      description = "Limits the depth of the exploration of the state space.",
      default     = 100,
      type        = "number",
      update      = true,
    },
    states_limit = {  -- nouvelle option
      [refines]   = { ref [meta].parameter_type },
      name        = "states_limit", -- "Depth limit" "depth-limit"
      description = "will try to stop after reaching this number of states. Warning: the program may have to first finish computing the current iteration before stopping.",
      default     = 10000,
      type        = "number",
      update      = true,
    },
    time_limit = {  -- nouvelle option
      [refines]   = { ref [meta].parameter_type },
      name        = "time_limit",
      description = "Time limit in seconds. Warning: no guarantee that the program will stop exactly after the given amount of time. In cartography, this limit applies to each call to IM; use -cart-time-limit for a global limit.",
      default     = 60,
      type        = "number",
      update      = true,
    },
  }

  optionsdisplay.run = function (options)
    -- local model = options.model.graph
    local model = options.model.options.graph
    model.nb_vertices = 0
    model.nb_edges    = 0
    for _ in pairs (model.vertices) do
      model.nb_vertices = model.nb_vertices+1
    end
    for _ in pairs (model.edges) do
      model.nb_edges = model.nb_edges+1
    end
    print ("version 0.02")
    print ("#vertices:", model.nb_vertices)
    print ("#edges   :", model.nb_edges   )
  end

  return optionsdisplay

end
