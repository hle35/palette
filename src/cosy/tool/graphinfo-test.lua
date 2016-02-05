return function (Layer)

  local labels  = Layer.key.labels
  local refines = Layer.key.refines
  local graph   = Layer.require "cosy/formalism/graph"

  local instance = Layer.new {
    name = "cosy/tool/graphinfo.test",
  }

  instance [labels] = {
    ["cosy/tool/graphinfo.test"] = true
  }
  local _ = Layer.reference "cosy/tool/graphinfo.test"

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
  instance.edges    = {
    e1 = {
      arrows = {
        input  = _.vertices.a,
        output = _.vertices.b,
      }
    },
    e2 = {
      arrows = {
        input  = _.vertices.b,
        output = _.vertices.c,
      }
    },
    e3 = {
      arrows = {
        input  = _.vertices.c,
        output = _.vertices.d,
      }
    },
    e4 = {
      arrows = {
        input  = _.vertices.d,
        output = _.vertices.e,
      }
    },
  }

  return instance

end
