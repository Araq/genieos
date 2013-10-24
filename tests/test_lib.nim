## Tests genieos module procs.

import genieos, strutils, os

proc test_recycle() =
  var filename : string

  echo "Creating thousand directories to later recycle them."
  for f in 0..999:
    filename = "onetest$1.todelete" % $f
    createDir filename
    recycle filename

proc test_clipboard() =
  let text = get_clipboard_string()
  echo "Clipboard content ", if text.isNil: "(nil)" else: $text


proc poll_clipboard() =
  let first_change = get_clipboard_change_timestamp()
  echo "Polling the clipboard, copy something to exit the program!"
  while first_change == get_clipboard_change_timestamp():
    sleep(500)
  echo "Clipboard did change, stopping infinite loop."


proc test_change_clipboard() =
  let
    first_change = get_clipboard_change_timestamp()
    input_string = "Nimrod is awesome!"

  set_clipboard("Nimrod is awesome!")
  assert get_clipboard_change_timestamp() != first_change
  let readback_string = $get_clipboard_string()
  assert readback_string == input_string
  echo "Was able to change clipboard to '" & input_string & "'"


when isMainModule:
  test_clipboard()
  #poll_clipboard()
  test_change_clipboard()
  test_recycle()
  echo "All tests done!"
