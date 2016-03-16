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
    local ancestors   = {}
    local candidates  = {}
    for key1, value1 in pairs (model [meta]) do
      print ("#key1:", key1)
      print ("#value1:", value1)
      for key2, value2 in pairs (model [meta]) do
        print ("#key2:", key2)
        print ("#value2:", value2)
        if value1 < value2 then  -- value1 is an ancestor of value2 
          ancestors [ value1 ] = true ;
          print ("ancestor  #value1:", value1)
        else
          candidates [ value1 ] = true ;
          print ("candidate  #value1:", value1)
        end
      end
    end
    -- remove every ancestors from candidates
    for key3, _ in pairs (ancestors) do
	candidates [ key3 ] = nil ;
    end
    print ("Temporary candidates:")
    for k,v in pairs(candidates) do print(k,v) end
    -- remove items not descendant from edge nor vertex
    for key4, _ in pairs (candidates) do
      if (( model [meta].vertex_type <= key4 ) or ( model [meta].edge_type   <= key4 )) then
        print ("keeping descendant ", key4)
      else
        print ("removing not descendant ", key4)
	candidates [ key4 ] = nil ;
      end
    end
    print ("Final candidates:")
    for k,v in pairs(candidates) do print(k,v) end

    ----------------------
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
