package = "cosy-graphinfo"
version = "master-1"

source = {
  url = "git://github.com/CosyVerif/tool-graphinfo",
}

description = {
  summary     = "Compute #vertices and #edges of a graph",
  detailed    = [[]],
  license     = "MIT/X11",
  maintainer  = "Alban Linard <alban@linard.fr>",
}

dependencies = {
  "cosy-formalisms",
  "cosy-client",
}

build = {
  type    = "builtin",
  modules = {
    ["cosy.tool.graphinfo"] = "src/cosy/tool/graphingo.lua",
  },
}
