[![Build Status](https://travis-ci.org/CosyVerif/tool-graphinfo.svg?branch=master)](https://travis-ci.org/CosyVerif/tool-graphinfo)
[![Coverage Status](https://coveralls.io/repos/CosyVerif/tool-graphinfo/badge.svg?branch=master&service=github)](https://coveralls.io/github/CosyVerif/tool-graphinfo?branch=master)
[![Join the chat at https://gitter.im/CosyVerif/tool-graphinfo](https://badges.gitter.im/CosyVerif/tool-graphinfo.svg)](https://gitter.im/CosyVerif/tool-graphinfo?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

# Graph info in CosyVerif

This repository provides a small tool to compute the number of vertices and
edges in any graph.
It can be forked and used as a template for integrating tools into the
CosyVerif platform.
This tool comes in two flavors: one written purely in Lua, and one that calls
external tools to compute its result.

## Install

This module is available in [luarocks](https://luarocks.org):

```sh
    luarocks install cosy-graphinfo
```

## Usage

Running a tool is performed using the `cosy-tool` command, automatically
installed by the `cosy-client` dependency.
This command takes as first argument the name of the tool, written using the
cosy standard: `user/project/tool`.
You can obtain the tool parameters by adding `--help` after the tool parameter:

```sh
  $ cosy-tool cosy/tool/graphinfo --help
  Usage: cosy-tool cosy/tool/graphinfo [--graph <graph>] [-h]

  Computes #vertices and #edges of a graph.

  Options:
     --graph <graph>       graph to analyze (<cosy/formalism/graph>)
     -h, --help            Show this help message and exit.
```

Tool parameters, like `graph`, are represented as options to allow their naming,
but are in fact mandatory.
The expected data type is given in their description.
In our example, `<cosy/formalism/graph>` means that the tool expects a graph
model.

A small graph model is installed automatically for testing purpose:
`cosy/tool/graphinfo-test`.
You can test the tool with the following commands:

```sh
  $ cosy-tool cosy/tool/graphinfo        --graph=cosy/tool/graphinfo-test
  #vertices:	5
  #edges   :	4
  model has been output to /tmp/lua_...
  $ cosy-tool cosy/tool/graphinfo-binary --graph=cosy/tool/graphinfo-test
  #vertices:	5
  #edges   :	4
  model has been output to /tmp/lua_...
```

The first version of `graphinfo` is written in pure Lua, whereas the second
one calls the `wc` command to compute its result.
Results are usually put within the tool model.
`cosy-tool` dumps this model to allow you to look at it.

## How to write a tool

To write a tool wrapper, start by forking this repository.

A tool is represented in CosyVerif using a formalism that refines the
`cosy/formalism/tool` one
([defined here](https://github.com/CosyVerif/formalisms/blob/master/src/cosy/formalism/tool/init.lua)).
To learn more on formalisms, consult their
[README](https://github.com/CosyVerif/formalisms).

A cosy tool describes is basically a textual description of its purpose
and its parameter(s), each one with a name, a description, an optional default
value and a type.
The type is either a string corresponding to a Lua type ("string", "number",
"boolean", "function") or a reference to another formalism.
