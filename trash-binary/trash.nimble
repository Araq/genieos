[Package]
name          = "genieos_trash"
version       = "0.1"
author        = "Grzegorz Adam Hankiewicz"
description   = """
OSX command line tool to recycle files.

This program is optional and not required for the genieos package, it only
works on OS X anyway.
"""
license       = "MIT"
bin           = "trash"

[Deps]
Requires: """

nake >= 1.0
argument_parser >= 0.1.2
x11 >= 1.0
https://github.com/gradha/badger_bits.git >= 0.2.4

"""
