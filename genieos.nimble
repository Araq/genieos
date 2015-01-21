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
trash-binary/trash.nim
trash-binary/trash.nimble
trash-binary/trash.nimrod.cfg

"""

[Deps]
Requires: """

x11 >= 1.0

"""
