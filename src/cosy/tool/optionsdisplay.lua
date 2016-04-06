return function (Layer, optionsdisplay, ref)

--   This version is a draft example to test the command line options :
-- cosy-tool cosy/tool/optionsdisplay  --graph=cosy/tool/graphinfo-test --depth_limit=10
-- cosy-tool cosy/tool/optionsdisplay  --graph=cosy/tool/graphinfo-test --depth_limit=10 --merge_states=false --output_states_description=true
-- cosy-tool cosy/tool/optionsdisplay  --graph=cosy/tool/graphinfo-test --depth_limit=10 --states_limit=1000 --time_limit=100 --imk=true --imunion=true --random_selection=true --merge_states=true --output_states_description=true --output_trace_set=true

--   Note: the "key" field of options is automatically generated from "name" field (eg to suppress spaces)

--[[
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

--]]
--[[


<div class="container">
  <h2 >Options (IM Layout)</h2>

  <form class="form-horizontal" role="form">

    <div class="form-group">
      <label class="control-label col-sm-2" for="depth_limit">Depth limit</label>
      <div class="col-sm-2">
        <input type="text" class="form-control" id="depth_limit"  value="100">
      </div>
      <span class="glyphicon glyphicon-info-sign" data-toggle="tooltip" title="Maximum depth of the state space."></span>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="states_limit">States limit</label>
      <div class="col-sm-2">
        <input type="text" class="form-control" id="states_limit" value="10000">
      </div>
      <span class="glyphicon glyphicon-info-sign" data-toggle="tooltip" title="Maximum number of states to explore." data-original-title="Security Code"></span>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="time_limit">Time limit</label>
      <div class="col-sm-2">
        <input type="text" class="form-control" id="time_limit" value="60">
      </div>
      <span class="glyphicon glyphicon-info-sign" data-toggle="tooltip" title="Maximum execution time (in seconds)."></span>
    </div>
    <div class="form-group">
      <div class="controls">
          <label class="control-label col-sm-2"> IMK </label> <input  class="control-label col-sm-1" type="checkbox"  id="imk" />
      </div>
      <span class="glyphicon glyphicon-info-sign" data-toggle="tooltip" title="Algorithm IMoriginal [AS11]."></span>
    </div>
<div class="form-group">
  <div class="controls">
	  <label class="control-label col-sm-2"> IMunion </label>  <input  class="col-sm-1" type="checkbox"  id="imunion"  />
  </div>
      <span class="glyphicon glyphicon-info-sign" data-toggle="tooltip" title="Algorithm IMUnion [AS11]."></span>
</div>

    <div class="form-group">
      <div class="controls">
          <label class="control-label col-sm-2"> Random selection </label> <input  class="col-sm-1" type="checkbox" id="random_selection"  checked="checked" />
      </div>
      <span class="glyphicon glyphicon-info-sign" data-toggle="tooltip" title="Random selection of pi-incompatible states to be negated."></span>
    </div>
    <div class="form-group">
      <div class="controls">
          <label class="control-label col-sm-2"> Dynamic elimination</label> <input  class="col-sm-1" type="checkbox"   id="dynamic_elimination"  />
      </div>
      <span class="glyphicon glyphicon-info-sign" data-toggle="tooltip" title="Dynamic clock elimination [And13]."></span>
    </div>
    <div class="form-group">
      <div class="controls">
          <label class="control-label col-sm-2">  Inclusion check </label> <input  class="col-sm-1" type="checkbox"  id="inclusion_check" />
      </div>
      <span class="glyphicon glyphicon-info-sign" data-toggle="tooltip" title="Fixpoint by inclusion check instead of equality check."></span>
    </div>
    <div class="form-group">
      <div class="controls">
          <label class="control-label col-sm-2">  Merge states </label> <input  class="col-sm-1" type="checkbox"  id="merge_states" />
      </div>
      <span class="glyphicon glyphicon-info-sign" data-toggle="tooltip" title="Convex state merging [AFS13]."></span>
    </div>
    <div class="form-group">
      <div class="controls">
          <label class="control-label col-sm-2">  Output states description </label> <input  class="col-sm-1" type="checkbox"  id="output_states_description" checked="checked" />
      </div>
      <span class="glyphicon glyphicon-info-sign" data-toggle="tooltip" title="Return a textual description of all symbolic states."></span>
    </div>
    <div class="form-group">
      <div class="controls">
          <label class="control-label col-sm-2"> Output trace set </label> <input  class="col-sm-1" type="checkbox" id="output_trace_set" checked="checked" />
      </div>
      <span class="glyphicon glyphicon-info-sign" data-toggle="tooltip" title="Return the trace set in a graphical form."></span>
    </div>
  </form>
</div>



--]]
--[[
--]]

  local meta    = Layer.key.meta
  local refines = Layer.key.refines
  local tool    = Layer.require "cosy/formalism/tool"
  local graph   = Layer.require "cosy/formalism/graph"

  optionsdisplay [refines] = {
    tool
  }

  optionsdisplay.description = "Computes #vertices and #edges of a graph."

  optionsdisplay[meta] = {
    boolean_parameter = {
      [refines] = { ref [meta].parameter_type },
      render    = function (opt)
        -- print ("generic render for boolean_parameter :", opt.name, opt.key, " option ", opt.description)
        -- return "generic render for boolean_parameter :" .. opt.name .. " " .. opt.key .. " option " .. opt.description
	local checked = "checked=\"checked\""
        if (opt.default == false) then  checked = "" end
        local html = ""
        html = html .. "<div class=\"form-group\">"
        html = html .. "<div class=\"controls\">"
--[[
--]]
        html = html .. "<label class=\"control-label col-sm-2\">" .. opt.name .. "</label> <input  class=\"col-sm-1\" type=\"checkbox\" name=\"" .. opt.key .. "\"  id=\"" .. opt.key .. "\" "  .. checked .. "/>"
        html = html .. "</div>"
        html = html .. "<span class=\"glyphicon glyphicon-info-sign\" data-toggle=\"tooltip\" title=\"" .. opt.description .."\"></span>"
        html = html .. "</div>"
        return html
      end,
      type        = "boolean",
    },
    number_parameter = {
      [refines] = { ref [meta].parameter_type },
      render    = function (opt)
        --print ("generic render for number_parameter :", opt.name, opt.key, " option ", opt.description)
        --return "generic render for number_parameter :" .. opt.name .. " " .. opt.key .. " option " .. opt.description
        local html = ""
        html = html .. "<div class=\"form-group\">"
        html = html .. "<label class=\"control-label col-sm-2\" for=\"" .. opt.key .. "\">" .. opt.name .. "</label>"
        html = html .. "<div class=\"col-sm-2\">"
        html = html .. "<input type=\"text\" class=\"form-control\" name=\"" .. opt.key .. "\" id=\"" .. opt.key .. "\"   value=\"" .. opt.default .."\">"
        html = html .. "</div>"
        html = html .. "<span class=\"glyphicon glyphicon-info-sign\" data-toggle=\"tooltip\" title=\"" .. opt.description .."\"></span>"
        html = html .. "</div>"
        return html

      end,
      type        = "number",
    },
  }

  optionsdisplay.options = {
    -- options of the service
    graph = {
      [refines]   = { ref [meta].parameter_type },
      name        = "graph",
      key         = "graph",
      description = "graph to analyze",
      default     = nil,
      type        = graph,
      update      = true,
      render      = function (opt)
        --print ("specific_rendering_for_graph ", opt.name, opt.key, " option ", opt.description)
        return "specific_rendering_for_graph " .. opt.name .. " " .. opt.key .. " option " .. opt.description
      end,
    },
    depth_limit = {
      [refines]   = { ref [meta].number_parameter },
      name        = "Depth limit",
      key         = "depth_limit",
      description = "Maximum depth of the state space.",
      default     = 100,
    },
    states_limit = {
      [refines]   = { ref [meta].number_parameter },
      name        = "States limit",
      key         = "states_limit",
      description = "Maximum number of states to explore.",
      default     = 10000,
    },
    time_limit = {
      [refines]   = { ref [meta].number_parameter },
      name        = "Time limit",
      key         = "time_limit",
      description = "Maximum execution time (in seconds).",
      default     = 60,
    },
--[[
--]]
    imk = {
      [refines]   = { ref [meta].boolean_parameter },
      name        = "IMK",
      key         = "imk",
      description = "Algorithm IMoriginal [AS11].",
      default     = false,
    },
    imunion = {
      [refines]   = { ref [meta].boolean_parameter },
      name        = "IMunion",
      key         = "imunion",
      description = "Algorithm IMUnion [AS11].",
      default     = false,
    },
    random_selection = {
      [refines]   = { ref [meta].boolean_parameter },
      name        = "Random selection",
      key         = "random_selection",
      description = "Random selection of the pi-incompatible to be negated.",
      default     = true,
    },
    dynamic_elimination = {
      [refines]   = { ref [meta].boolean_parameter },
      name        = "Dynamic elimination",
      key         = "dynamic_elimination",
      description = "Dynamic clock elimination [And13].",
      default     = false,
    },
    inclusion_check = {
      [refines]   = { ref [meta].boolean_parameter },
      name        = "Inclusion check",
      key         = "inclusion_check",
      description = "Fixpoint by inclusion check instead of equality check.",
      default     = false,
    },
    merge_states = {
      [refines]   = { ref [meta].boolean_parameter },
      name        = "Merge states",
      key         = "merge_states", 
      description = "Convex state merging [AFS13].",
      default     = false,
    },
    output_states_description = {
      [refines]   = { ref [meta].boolean_parameter },
      name        = "Output states description",
      key         = "output_states_description",
      description = "Return a textual description of all symbolic states.",
      default     = true,
    },
    output_trace_set = {
      [refines]   = { ref [meta].boolean_parameter },
      name        = "Output trace set",
      key         = "output_trace_set",
      description = "Return the trace set in a graphical form.",
      default     = true,
    },

--[[
--]]
    -- rendering functions
    render_start_option_form = function ()
      --print ("snippet to start options pane")
      local html = ""
      html = html .. "<div class=\"container\">"
      html = html .. "<h2 >Options (IM Layout)</h2>"
      html = html .. "<form class=\"form-horizontal\" role=\"form\" id=\"optionsform\" action=\"show_im_options.html\" method=\"get\">"
      --html = html .. "<form class=\"form-horizontal\" role=\"form\">"
      return html
--[[
  </form>
</div>
--]]
    end,
    render_end_option_form = function ()
      --print ("snippet to end options pane")
      local html = ""
      html = html .. "</form>"
      html = html .. "</div>"
      return html
    end,
    render_option_editable_number = function (opt)
      assert(opt.type == "number")
      print ("render_end_option_form: a form for number " , opt.name)
    end,
    render_option_editable_boolean = function (opt)
      assert(opt.type == "boolean")
      print ("render_option_editable_boolean: a form for boolean " , opt.name)
    end,
    render = function (options)
      print ("render options pane")
      local html = ""
      html = optionsdisplay.options.render_start_option_form() 
      print (html)
      -- we specify the order in which options must be rendered
      local rendering_order = {
        --  "graph",  -----  PAS DE RENDERING POUR GRAPH pour l'instant
        "depth_limit",
        "states_limit",
        "time_limit",
        "imk",
        "imunion",
        "random_selection",
        "dynamic_elimination",
        "inclusion_check",
        "merge_states",
        "output_states_description",
        "output_trace_set",
      }
      print("<!--**************************-->")
      for i, opt in ipairs(rendering_order) do
        --print(i,opt)
        if ( optionsdisplay.options[opt].render ~= nil ) then
           --print( optionsdisplay.options[opt].name )
           --print( optionsdisplay.options[opt].description )
           local html = "" 
           html = optionsdisplay.options[opt]:render()
           print(html)
         else
           print("!!!!!!no rendering")
        end
      end
      print("<!--**************************-->")
      html = ""
      html = optionsdisplay.options.render_end_option_form() 
      print (html)
    end,
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
    print ("version 0.05")
    print ("#vertices:", model.nb_vertices)
    print ("#edges   :", model.nb_edges   )
  end

  return optionsdisplay

end
