# Tests osx clipboard functionality.
#
# This will overwrite the current clipboard contents using pbcopy.

import
  genieos, strutils, os, math


const temp_file = "clipboard_payload.txt"


proc generate_data(): string =
  ## Returns the contents of this file plus a random value.
  result = read_file("test_clipboard_osx.nim")
  randomize()
  let value = $random(int.high)
  result.add(value)


proc test_osx() =
  let data = generate_data()
  temp_file.write_file(data)
  let first_timestamp = get_clipboard_change_timestamp()
  doAssert exec_shell_cmd("cat " & temp_file & " | pbcopy ") == 0
  let second_timestamp = get_clipboard_change_timestamp()
  doAssert first_timestamp != second_timestamp
  let readback_string = get_clipboard_string()
  doAssert data == readback_string


when isMainModule:
  when defined(macosx):
    test_osx()
    echo "All tests done!"
  else:
    echo "Unsupported platform, ignoring tests."
