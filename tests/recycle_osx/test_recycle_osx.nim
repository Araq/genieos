# Tests osx recycling.

import genieos, os

proc test_recycle() =
  var filename : string

  echo "Creating thousand directories to later recycle them."
  for f in 0..999:
    filename = "onetest" & $f & ".todelete"
    createDir filename
    recycle filename


when isMainModule:
  when defined(macosx):
    test_recycle()
    echo "All tests done!"
  else:
    echo "Unsupported platform, ignoring tests."
