import bb_nake, bb_os, times, osproc, sequtils

let
  modules = @["genieos"]
  rst_files = concat(glob("*.rst"), glob("docs"/"*rst"),
    glob("trash-binary"/"*.rst"))

proc nimble_install() =
  direshell("nimble install -y")
  echo "Now you can 'import genieos' and wait for a wish."

iterator all_rst_files(): tuple[src, dest: string] =
  for rst_name in rst_files:
    var r: tuple[src, dest: string]
    r.src = rst_name
    # Ignore files if they don't exist, nimble version misses some.
    if not r.src.existsFile:
      echo "Ignoring missing ", r.src
      continue
    r.dest = rst_name.change_file_ext("html")
    yield r


proc doc() =
  # Generate documentation for the nim modules.
  for module in modules:
    let
      nim_file = module & ".nim"
      html_file = module & ".html"
    if not html_file.needs_refresh(nim_file): continue
    if not shell(nim_exe, "doc --verbosity:0", module):
      quit("Could not generate module for " & module)
    else:
      echo "Generated " & module & ".html"

  # Generate html files from the rst docs.
  for rst_file, html_file in all_rst_files():
    if not html_file.needs_refresh(rst_file): continue
    if not shell(nim_exe, "rst2html --verbosity:0", rst_file):
      quit("Could not generate html doc for " & rst_file)
    else:
      echo rst_file & " -> " & html_file
  echo "All done"

proc validate_rst() =
  for rst_file, html_file in all_rst_files():
    echo "Testing ", rst_file
    let (output, exit) = execCmdEx("rst2html.py " & rst_file & " > /dev/null")
    if output.len > 0 or exit != 0:
      echo "Failed python processing of " & rst_file
      echo output

task "install", "Uses nimble to install locally": nimble_install()
task "i", "Alias for install": nimble_install()
task "doc", "Generates export API docs for for the modules": doc()
task "check_doc", "Validates rst format for some docs": validate_rst()
