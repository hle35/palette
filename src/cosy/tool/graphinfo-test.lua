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
        input  = ref.vertices.a,
        output = ref.vertices.b,
      }
    },
    e2 = {
      arrows = {
        input  = ref.vertices.b,
        output = ref.vertices.c,
      }
    },
    e3 = {
      arrows = {
        input  = ref.vertices.c,
        output = ref.vertices.d,
      }
    },
    e4 = {
      arrows = {
        input  = ref.vertices.d,
        output = ref.vertices.e,
      }
    },
  }

  return instance

end
