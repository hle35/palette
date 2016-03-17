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
        print (" which has rendering ", key4.rendering)
      else
        print ("removing not descendant ", key4)
	candidates [ key4 ] = nil ;
      end
    end
    -- adding select and delete and title
    local title = {["title"] = "Palette", ["rendering"] = "<text x=\"40\" y=\"15\" fill=\"black\" font-weight=\"bold\">Palette</text>", } ;
    local select_ = {["name"] = "select", ["rendering"] = "<text x=\"20\" y=\"40\" fill=\"blue\">select</text>", } ;
    local delete = {["name"] = "delete", ["rendering"] = "<text x=\"20\" y=\"70\" fill=\"red\">delete</text>", } ;
    candidates [ title ] = true ;
    candidates [ select_ ] = true ;
    candidates [ delete ] = true ;
    local lapalette = candidates
    print ("Palette content:")
    for k,_ in pairs(lapalette) do
      print(k," which has rendering ", k.rendering)
      if (k == model [meta].edge_type ) then
        print("\tand sub key arrow_type which has rendering ", k[meta].arrow_type.rendering )
      end
      if (type(k) == "table") then
        for key5, value5 in pairs (k) do
          if (key5 ~= "renderingggggggg") then
            print("\tand sub #key5:", key5," and #value5:", value5 )
          end
        end
      end
    end
    -- display svg palette
    print ("<!DOCTYPE html>\n<html>\n<head>\n<meta charset=\"utf-8\">\n</head>\n<body>")
    print ("<svg width=\"800px\" height=\"800px\" viewbox=\"0 0 800 800\">")
    print(model [meta].edge_type[meta].arrow_type.rendering)
    for k,_ in pairs(lapalette) do
      print(k.rendering)
    end
    print ("</svg>")
    print ("</body>\n</html>")

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
