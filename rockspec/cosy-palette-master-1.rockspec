package = "cosy-palette"
version = "master-1"

source = {
  url = "git://github.com/hle35/palette",
}

description = {
  summary     = "Compute the palette to edit a graph",
  detailed    = [[]],
  license     = "MIT/X11",
  maintainer  = "Hugues Leprieur <hle35@gmail.com>",
}

dependencies = {
  "cosy-formalisms",
  "cosy-client",
  "copas-ev",
}

build = {
  type    = "builtin",
  modules = {
    ["cosy.tool.graphinfo"       ] = "src/cosy/tool/graphinfo.lua",
    ["cosy.tool.graphinfo-binary"] = "src/cosy/tool/graphinfo-binary.lua",
    ["cosy.tool.graphinfo-test"  ] = "src/cosy/tool/graphinfo-test.lua",
    ["cosy.tool.palette"         ] = "src/cosy/tool/palette.lua",
    ["cosy.tool.palette-test"    ] = "src/cosy/tool/palette-test.lua",
  },
}
