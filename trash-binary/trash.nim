import genieos, argument_parser, tables, os, osproc

const
  PARAM_SILENT = @["-s", "--silent"]
  PARAM_SOUND = @["-S", "--sound"]
  PARAM_VERBOSE = @["-v", "--verbose"]
  PARAM_VERSION = @["-V", "--version"]
  PARAM_HELP = @["-h", "--help"]


proc process_commandline(): Tcommandline_results =
  ## Processes the commandline.
  ##
  ## Returns the positional parameters if they were specified, plus the
  ## optional switches specified by the user.
  var params: seq[Tparameter_specification] = @[]
  params.add(new_parameter_specification(names = PARAM_VERBOSE,
    help_text = "Be verbose about files being recycled"))
  params.add(new_parameter_specification(names = PARAM_VERSION,
    help_text = "Display version numbers and exit"))
  params.add(new_parameter_specification(names = PARAM_SOUND,
    help_text = "Plays recycle bin sound and exits"))
  params.add(new_parameter_specification(names = PARAM_HELP,
    help_text = "Displays commandline help and exits", consumes = PK_HELP))
  params.add(new_parameter_specification(names = PARAM_SILENT,
    help_text = "Don't trigger OS sounds during recycle bin operations"))

  result = parse(params)

  if result.options.hasKey(PARAM_VERSION[0]):
    echo "Versions:"
    echo "\tgenieos ", genieos.version_str
    echo "\targument_parser ", argument_parser.version_str
    quit()

  if result.options.hasKey(PARAM_SOUND[0]):
    return

  if result.positional_parameters.len < 1:
    echo "Please specify a file or directory to send to the recycle bin"
    echo_help(params)
    quit()


proc process(filename: string, verbose: bool): bool =
  ## Recycles the specified path.
  ##
  ## Returns true if the path was recycled correctly.
  if verbose:
    echo "Recycling " & filename
  try:
    recycle filename
    result = true
  except EOS:
    echo "Sorry, could not recycle " & filename

proc play_sound_blocking() =
  ## Plays the recycle sound blocking the current thread/process.
  let wait = playSound(recycleBin)
  sleep(int(1000 * wait))


proc play_sound_async() =
  ## Plays the recycle sound asyncronously by invoking another process.
  ##
  ## The Cocoa API doesn't work in forked environments (see
  ## http://stackoverflow.com/questions/15991036/why-cant-i-use-cocoa-frameworks-in-different-forked-processes)
  ## so we have to spawn a new process to invoke ourselves from the commandline
  ## in the background and avoid blocking the main thread.
  let procname = paramStr(0)
  if procname.existsFile():
    #echo "Running first"
    discard(startProcess(procname, args = @["-S"]))
  else:
    let search_binary = findExe(getAppFilename())
    if search_binary.existsFile():
      #echo "Running found binary"
      discard(startProcess(search_binary, args = @["-S"]))
    else:
      #echo "Running shell version"
      discard(startProcess(procname, args = @["-S"], options = {poUseShell}))


when isMainModule:
  let args = process_commandline()
  if args.options.hasKey(PARAM_SOUND[0]):
    play_sound_blocking()
    quit()

  var count = 0
  for param in args.positional_parameters:
    if process(param.str_val, args.options.hasKey(PARAM_VERBOSE[0])):
      count += 1
  if count > 0 and not args.options.hasKey(PARAM_SILENT[0]):
    play_sound_async()
