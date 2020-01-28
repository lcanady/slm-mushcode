# Global Format Object

This repo contains the Silver Line Mush Global Format Object. This repo uses [mush-formatter](https://github.com/digibear-io/mush-format). A fully compiled version of the code is aviable in `/dist`.

**This Repo is a Demo Right now**

This repo is still being built, and not 100% functional. When it's ready, I'll push to the master branch and tag it.

## Installation

To install the global format object, quote the file `format.$v.min.txt` where `$v` is the version number of the repository. I suggest giving a delay of `1 sec/line` at least.

## Commands

The format object contains a configuration tool, to assist in setting the config attributes on the formatter object.

- `@fmt` The configuration command for the global format object.
  - `@fmt[/help]` A list of commands available on the global format object.
  - `@fmt <config>=<setting>` Update a configuration setting on the Global Format Object. For a list of possible config settings, see [Configuration](#configuration).
  - `@fmt/reset` Reset the global configuration settings to 'factory'.

## Global Functions

The following global functions are available.

- `header(<Title>[,<just>][,<lhs>][,<rhs>][,<sep>][,<length>])` Create a header. If any of the options are left empty, they will be filled with global defaults. See [Configuration](#configuration) for a list of optiosn.

## Configuration

- `header()`
  - `&d.jus` Set the default justifaction for the header (**default: center**)
  - `&d.lhs` The text on the left-hand side of the title. (**default: <<**)
  - `&d.rhs` The text on the right-hand side of the title. (**default: >>**)
  - `&d.sep` The characters used to fill space (**default: -**)
  - `&d.len` The default line length for a header.  (**default: 78**)
