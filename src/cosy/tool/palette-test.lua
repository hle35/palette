return function (Layer, instance, ref)

  local meta    = Layer.key.meta
  local refines = Layer.key.refines
  local graph   = Layer.require "cosy/formalism/graph"

  instance [refines] = {
    graph
  }

  -- SVG rendering definition inside the model not the formalism
  instance [meta].vertex_type.rendering = "<circle cx='50' cy='50' r='40' stroke='black'  stroke-width='3' fill='black' /> <!-- vertex svg-->" 
  instance [meta].edge_type.rendering   = "<path d='m 50, 150 q -50 50 0 150'  style=\"marker-end: url(#mTriangle); fill: none; stroke: blue;\"/> <!-- edge svg -->" 
  instance [meta].edge_type [meta].arrow_type.rendering = "<defs> <!-- definition of a triangle extremity of the arrows  -->" ..
                                                          "  <marker id=\"mTriangle\" markerWidth=\"5\" markerHeight=\"10\"" ..
                                                          "    refX=\"5\" refY=\"5\" orient=\"auto\">" ..
                                                          "    <path d=\"M 0 0 5 5 0 10 Z\" style=\"fill: black;\"/>" ..
                                                          "  </marker>" ..
                                                          "</defs><!-- arrow svg -->"


  instance.vertices = {
    a = "a",
    b = "b",
    c = "c",
    d = "d",
    e = "e",
  }
  instance.edges = {
    e1 = {
      arrows = {
        { vertex = ref.vertices.a,
          input  = true },
        { vertex = ref.vertices.b,
          output = true },
      }
    },
    e2 = {
      arrows = {
        { vertex = ref.vertices.b,
          input  = true },
        { vertex = ref.vertices.c,
          output = true },
      }
    },
    e3 = {
      arrows = {
        { vertex = ref.vertices.c,
          input  = true },
        { vertex = ref.vertices.d,
          output = true },
      }
    },
    e4 = {
      arrows = {
        { vertex = ref.vertices.d,
          input  = true },
        { vertex = ref.vertices.e,
          output = true },
      }
    },
  }

  return instance

end
