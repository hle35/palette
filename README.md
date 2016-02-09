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

If you do not have a Lua installation, you can use
[hererocks](https://github.com/mpeterv/hererocks):

```sh
  (install python pip)
  pip install hererocks
  hererocks lua_install -r^ --lua=5.2
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

## Tutorial

A tool is represented in CosyVerif using a formalism that refines the
`cosy/formalism/tool` one
([defined here](https://github.com/CosyVerif/formalisms/blob/master/src/cosy/formalism/tool/init.lua)).
To learn more on formalisms, consult their
[README](https://github.com/CosyVerif/formalisms).

So, first write the skeleton of your tool, that should look like below.
It declares a new formalism named `myuser/myproject/mytool`.
Naming should follow this pattern, as it corresponds to a valid identifier
in the CosyVerif platform.

Its translation into the file system requires that your tool is put in file
`myuser/myproject/mytool.lua` (or `myuser/myproject/mytool/init.lua`).
See [require function](http://www.lua.org/pil/8.1.html) for deeper explanations.

```lua
return function (Layer, mytool, ref)

  local checks  = Layer.key.checks
  local default = Layer.key.default
  local labels  = Layer.key.labels
  local meta    = Layer.key.meta
  local refines = Layer.key.refines

  ...

end
```

Your tool **must** refine the `cosy/formalism/tool` formalism.
So, put the following lines within the `...`.
Of course, your tool can also refine another formalism or model.
In that case, feel free to add them to the `refines` list.

```lua
  local tool = Layer.require "cosy/formalism/tool"
  mytool [refines] = {
    tool,
  }
```

The next step is to describe your tool.
You should give a textual description to your tool by adding a `description`
field. Currently, there is no support for internationalization, but we will
provide some in future versions.

```lua
  mytool.description = "The coolest tool in the universe!"
```

We can now define the parameters of the tool.
A parameter is simply a part of the formalism that refines
`_ [meta].parameter_type`.
They can be at the root, or anywhere within the hierarchical structure of the
tool description.
A parameter has the following description.

```lua
  mytool.myparameter = {
    [refines]   = { _ [meta].parameter_type },
    name        = "myparameter",
    description = "the coolest parameter in the universe",
    type        = "boolean",
    default     = true,
    update      = true,
  }
```

The `type` fields describes the parameter type.
It can be either a string representing a primitive type
(``"boolean"``, ``"number"``, ``"string"``, ``"function"``) or a reference
to a formalism or a part of it.
In the latter case, the effective parameter must refine the given `type`.

The `default` field gives a default value to the parameter.
It can be undefined by having value `nil` or being absent.

The `update` field is only used when the parameter is another formalism or
model. This fields states that the parameter will be updatable. If you change
data within this parameter the original formalism or model will be changed.
Otherwise, changes will be put in an instance of your tool formalism.

After defining its parameters, we can define the tool behavior.
It is given in a function, called `run`, that takes one table as argument.
This table contains the following fields:

* `model` contains an instance of the tool, where parameters have been replaced
by their effective values;
* `scheduler` is a scheduler allowing to run commands or create threads.

Tools should not output their results. Instead, they should update the `model`
with computed results.
Putting all results within the model allows to easily reuse them later as input
for other tools.

***

Now that we have described our tool, we can run it in the command-line.
To do so, make sure that your sources are accessible using the `LUA_PATH`
environment variable. Then run:

```lua
$ cosy-tool myuser/myproject/mytool --help
```

All parameters should now appear as options.
You can give values for primitive types like `myparam=true`,
whereas formalisms or models are given by typing their module name,
for instance `myparam=cosy/formalism/graph`.
Don't worry, they are given in the correct type (and already loaded and parsed)
in the `run` function.
