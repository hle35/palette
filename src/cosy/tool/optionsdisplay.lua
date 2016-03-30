return function (Layer, optionsdisplay, ref)

--   This version is a draft example to test the command line options :
-- cosy-tool cosy/tool/optionsdisplay  --graph=cosy/tool/graphinfo-test --depth_limit=10
-- cosy-tool cosy/tool/optionsdisplay  --graph=cosy/tool/graphinfo-test --depth_limit=10 --merge_states=false --output_states_description=true
-- cosy-tool cosy/tool/optionsdisplay  --graph=cosy/tool/graphinfo-test --depth_limit=10 --states_limit=1000 --time_limit=100 --imk=true --imunion=true --random_selection=true --merge_states=true --output_states_description=true --output_trace_set=true

--   Note: the "key" field of options is automatically generated from "name" field (eg to suppress spaces)

--[[
List of the Option Contextual Help Messages :

	For IM
Depth limit: "Maximum depth of the state space"
States limit: "Maximum number of states to explore"
Time limit: "Maximum execution time (in seconds)"
IMK: "Algorithm IMoriginal [AS11]"
IMUnion: "Algorithm IMUnion [AS11]"
Random selection: "Random selection of pi-incompatible states to be negated"
Dynamic elimination: "Dynamic clock elimination [And13]"
Inclusion check: "Fixpoint by inclusion check instead of equality check"
Merge states: "Convex state merging [AFS13]"
Output states description: "Return a textual description of all symbolic states"
Output trace set: "Return the trace set in a graphical form"

	Idem for EFsynth
all idem

	Some are Different for BC
all idem excepted :
States limit: "Maximum number of states to explore for each call to the inverse method"
Cartography time limit: "Maximum execution time of the cartography (in seconds)"
Graphical cartography: "Return the cartography in a graphical form projected onto the first two parameter dimensions"

--]]
--[[
--]]
--[[
-- ajouter d'abord les fonctions de rendering
render_start_option_form = function ()
 print ("snippet to start options pane")
end
render_end_option_form = function ()
 print ("snippet to end options pane")
end
render_option_editable_number = function (option)
 assert(option.type == number)
 print ("a form for number " + option.name)
end
render_option_editable_boolean = function (option)
 assert(option.type == boolean)
 print ("a form for boolean " + option.name)
end
rendering = function (options)
 render_start_option_form ()
 for index,value in ipairs(tool_imitator_im.options) do
   print(index,value)
   if value.type == number then
     render_option_editable_number(value)
   elseif value.type == boolean then
     render_option_editable_boolean(value)
   end
 end
 render_end_option_form ()
end
--]]

  local meta    = Layer.key.meta
  local refines = Layer.key.refines
  local tool    = Layer.require "cosy/formalism/tool"
  local graph   = Layer.require "cosy/formalism/graph"

  optionsdisplay [refines] = {
    tool
  }

  optionsdisplay.description = "Computes #vertices and #edges of a graph."

  optionsdisplay.options = {
    -- options of the service
    graph = {
      [refines]   = { ref [meta].parameter_type },
      name        = "graph",
      description = "graph to analyze",
      default     = nil,
      type        = graph,
      update      = true,
      render      = function (graph)
        print ("render graph option ", graph.description)
      end,
    },
    depth_limit = {
      [refines]   = { ref [meta].parameter_type },
      name        = "Depth limit", 
      description = "Maximum depth of the state space.",
      default     = 100,
      type        = "number",
      update      = true,
      render      = function (depth_limit)
        print ("render depth_limit option ", depth_limit.description)
      end,
    },
--[[
    states_limit = {
      [refines]   = { ref [meta].parameter_type },
      name        = "States limit",
      description = "Maximum number of states to explore.",
      default     = 10000,
      type        = "number",
      update      = true,
    },
    time_limit = {
      [refines]   = { ref [meta].parameter_type },
      name        = "Time limit",
      description = "Maximum execution time (in seconds).",
      default     = 60,
      type        = "number",
      update      = true,
    },
    imk = {
      [refines]   = { ref [meta].parameter_type },
      name        = "IMK",
      description = "Algorithm IMoriginal [AS11].",
      default     = false,
      type        = "boolean",
      update      = true,
    },
    imunion = {
      [refines]   = { ref [meta].parameter_type },
      name        = "IMunion",
      description = "Algorithm IMUnion [AS11].",
      default     = false,
      type        = "boolean",
      update      = true,
    },
    random_selection = {
      [refines]   = { ref [meta].parameter_type },
      name        = "Random selection",
      description = "Random selection of the pi-incompatible to be negated.",
      default     = true,
      type        = "boolean",
      update      = true,
    },
    dynamic_elimination = {
      [refines]   = { ref [meta].parameter_type },
      name        = "Dynamic elimination",
      description = "Dynamic clock elimination [And13].",
      default     = false,
      type        = "boolean",
      update      = true,
    },
    inclusion_check = {
      [refines]   = { ref [meta].parameter_type },
      name        = "Inclusion check",
      description = "Fixpoint by inclusion check instead of equality check.",
      default     = false,
      type        = "boolean",
      update      = true,
    },
--]]
    merge_states = {
      [refines]   = { ref [meta].parameter_type },
      name        = "Merge states",
      description = "Convex state merging [AFS13].",
      default     = false,
      type        = "boolean",
      update      = true,
      render      = function (opt)
        print ("render ", opt.name, " option ", opt.description)
      end,
    },
    output_states_description = {
      [refines]   = { ref [meta].parameter_type },
      name        = "Output states description",
      description = "Return a textual description of all symbolic states.",
      default     = true,
      type        = "boolean",
      update      = true,
      render      = function (opt)
        print ("render ", opt.name, " option ", opt.description)  -- opt.key nil ?
      end,
    },
--[[
    output_trace_set = {
      [refines]   = { ref [meta].parameter_type },
      name        = "Output trace set",
      description = "Return the trace set in a graphical form.",
      default     = true,
      type        = "boolean",
      update      = true,
    },
--]]


--[[
--]]
    -- rendering functions
    render_start_option_form = function ()
      print ("snippet to start options pane")
    end,
    render_end_option_form = function ()
      print ("snippet to end options pane")
    end,
    render = function (options)
      print ("render options pane")
      optionsdisplay.options.render_start_option_form() 
      --print (" option graph " , options.graph)
      --print (" option graph name " , options.graph.name)
      --print (" option graph description " , options.graph.description)
      --print (" option graph render() " , options.graph.render())
      --print (" option depth_limit render() " , options.depth_limit.render())
      for k,v in pairs(optionsdisplay.options) do
        --print("\n")
        --print(k,v)
        --print(type(k))
        --print(type(v))
        if (type(v) == "table") then -- not a function : so it is an option
          --v.render()
          v:render()
        end
      end
      optionsdisplay.options.render_end_option_form() 
    end,
--[[
--]]
  }

  -- Rendering is **not** within the rool execution, but outside,
  -- because the formal parameters have been replaced by actual ones within
  -- the `run` function body.
  -- display the form for User to set the options
  optionsdisplay.options:render ()
  -- The use of render as a method call, not a function call, is better,
  -- as it allows code reuse.


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
    print ("version 0.04")
    print ("#vertices:", model.nb_vertices)
    print ("#edges   :", model.nb_edges   )
  end

  return optionsdisplay

end
