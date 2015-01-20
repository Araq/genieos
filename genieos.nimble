[Package]
name          = "genieos"
version       = "9.4.1"
author        = "Grzegorz Adam Hankiewicz"
description   = """Too awesome procs to be included in Nim's os module."""
license       = "MIT"
#bin           = "trash-binary/trash"

InstallFiles = """

LICENSE.rst
README.rst
docindex.rst
docs/CHANGES.rst
genieos.nim
nakefile.nim
private/genieos_macosx.m
trash-binary/README.rst
trash-binary/nimrod.cfg
trash-binary/trash.nim

"""

[Deps]
Requires: """

nake >= 1.0
argument_parser >= 0.1.2
x11 >= 1.0
https://github.com/gradha/badger_bits.git >= 0.2.4

"""
