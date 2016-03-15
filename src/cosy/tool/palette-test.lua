return function (Layer, instance, ref)

  local refines = Layer.key.refines
  local graph   = Layer.require "cosy/formalism/graph"

  instance [refines] = {
    graph
  }

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
