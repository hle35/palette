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
    local thepalette = {}
    -- adding select and delete and title
    local title = {["title"] = "Palette", ["rendering"] = "<text x=\"40\" y=\"15\" fill=\"black\" font-weight=\"bold\">Palette</text>", } ;
    local select_ = {["name"] = "select", ["rendering"] = "<text x=\"20\" y=\"40\" fill=\"blue\">select</text>", } ;
    local delete = {["name"] = "delete", ["rendering"] = "<text x=\"20\" y=\"70\" fill=\"red\">delete</text>", } ;
    thepalette [ title ] = true ;
    thepalette [ select_ ] = true ;
    thepalette [ delete ] = true ;
    for key0, value0 in pairs (model [meta]) do
      --print ("#key0:", key0)
      --print ("#value0:", value0)
      --print (" which has rendering ", value0.rendering)
      --print (" which has shouldBeInPalette ", value0.shouldBeInPalette)
      if (value0.shouldBeInPalette) then
        thepalette [ value0 ] = true ;
        -- print("adding to palette ",value0)
      else
        -- print("Do not add ",value0)
      end 
    end
    -- display svg palette
    print ("<!DOCTYPE html>\n<html>\n<head>\n<meta charset=\"utf-8\">\n</head>\n<body>")
    print ("<svg width=\"800px\" height=\"800px\" viewbox=\"0 0 800 800\">")
    print(model [meta].edge_type[meta].arrow_type.rendering)
    for k,_ in pairs(thepalette) do
      print( k.rendering)
      --if (k == model [meta].edge_type ) then
      --  print("\tand sub key arrow_type which has rendering ", k[meta].arrow_type.rendering )
      --end
    end
    print ("</svg>")
    print ("</body>\n</html>")

  end

  return palette

end
