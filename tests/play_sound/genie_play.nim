import genieos, argument_parser, tables, times, os

const
  PARAM_VERSION = @["-v", "--version"]
  PARAM_HELP = @["-h", "--help"]


proc process_commandline(): Tcommandline_results =
  ## Processes the commandline.
  ##
  ## Returns the positional parameters if they were specified, plus the
  ## optional switches specified by the user.
  var params: seq[Tparameter_specification] = @[]
  params.add(new_parameter_specification(names = PARAM_VERSION,
    help_text = "Display version numbers and exit"))
  params.add(new_parameter_specification(names = PARAM_HELP,
    help_text = "Displays commandline help and exits", consumes = PK_HELP))

  result = parse(params)

  if result.options.hasKey(PARAM_VERSION[0]):
    echo "Versions:"
    echo "\tgenieos ", genieos.version_str
    echo "\targument_parser ", argument_parser.version_str
    quit()

  if result.positional_parameters.len < 1:
    echo "Please specify files to attempt to play back."
    echo_help(params)
    quit()


proc process(filename: string) =
  ## Attempts to play back the specified filename.
  echo "Playing ", filename, "…"
  let wait = filename.play_sound
  if wait <= 0:
    echo "\tError, could not play!"
  else:
    sleep(int(wait * 1000))


proc main() =
  ## Entry point of the application.
  let args = process_commandline()
  for param in args.positional_parameters:
    process(param.str_val)
  echo "No more sounds to play."

when isMainModule: main()
