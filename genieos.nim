## Too awesome procs to be included in Nim's os module.
##
## This module contains several procs which are *too awesome* to be included in
## `Nim's <http://nim-lang.org>`_ `os module <http://nim-lang.org/os.html>`_.
## Procs may not be available for your platform, please check their
## availability at compile time with ``when`` and `declared
## <http://nim-lang.org/system.html#declared>`_.  Example checking for the
## availability of the `recycle() <#recycle>`_ proc:
##
## .. code-block:: Nimrod
##   when not declared(genieos.recycle):
##     proc recycle(filename: string):
##       if existsDir filename:
##         removeDir filename
##       else:
##         removeFile filename
##
## Source code for this module can be found at
## https://github.com/gradha/genieos.

import os

type
  TSound* = enum
    defaultBeep, recycleBin

const
  version_int* = (major: 9, minor: 4, maintenance: 3) ## \
  ## Module version as an integer tuple.
  ##
  ## Major versions changes mean a break in API backwards compatibility, either
  ## through removal of symbols or modification of their purpose.
  ##
  ## Minor version changes can add procs (and maybe default parameters). Minor
  ## odd versions are development/git/unstable versions. Minor even versions
  ## are public stable releases.
  ##
  ## Maintenance version changes mean I'm not perfect yet despite all the kpop
  ## I watch.

  version_str* = ($version_int.major & "." & $version_int.minor & "." &
      $version_int.maintenance) ## \
    ## Module version as a string. Something like ``1.9.2``.
    ##
    ## In addition to the numeric string, public release versions are nicknamed
    ## with the name of one singer from `Girls' Generation
    ## <https://en.wikipedia.org/wiki/Girls'_Generation>`_. Names iterate
    ## through the list in descending age order (in the Good Korea being older
    ## gives you instant priviledges over the rest):
    ##
    ## * 1989-03-09: `Kim Tae-yeon
    ##   <https://en.wikipedia.org/wiki/Kim_Tae-yeon>`_.
    ## * 1989-04-18: `Jessica Sooyoung Jung
    ##   <https://en.wikipedia.org/wiki/Jessica_Jung>`_.
    ## * 1989-05-15: `Susan Soonkyu Lee
    ##   <https://en.wikipedia.org/wiki/Sunny_(singer)>`_.
    ## * 1989-08-01: `Stephanie Young Hwang
    ##   <https://en.wikipedia.org/wiki/Tiffany_(South_Korean_singer)>`_.
    ## * 1989-09-22: `Kim Hyo-yeon
    ##   <https://en.wikipedia.org/wiki/Kim_Hyo-yeon>`_.
    ## * 1989-12-05: `Kwon Yuri <https://en.wikipedia.org/wiki/Kwon_Yuri>`_.
    ## * 1990-02-10: `Choi Soo-young
    ##   <https://en.wikipedia.org/wiki/Choi_Soo-young>`_.
    ## * 1990-05-30: `Im Yoona <https://en.wikipedia.org/wiki/Im_Yoona>`_.
    ## * 1991-06-28: `Seo Ju-hyun <https://en.wikipedia.org/wiki/Seohyun>`_.
    ##
    ## Note how Jessica is included because `she is a really talented idol
    ## <http://antikpopfangirl.blogspot.com.es/2015/04/positive-post-jessica-ex-snsd.html>`_.
    ## And because by the time v9.0.1 was released she was still in the group.

# Here comes the nimdoc block which declares the interface. It is only active
# during documentation generation to avoid compilation issues when something is
# not defined.
when defined(nimdoc):
  proc recycle*(filename: string)
    ## Moves a file or directory to the recycle bin of the user.
    ##
    ## If there are any errors recycling the file OSError will be raised. Note
    ## that unlike `os.removeFile() <http://nim-lang.org/os.html#removeFile>`_
    ## and `os.removeDir() <http://nim-lang.org/os.html#removeDir>`_ this works
    ## for any kind of file type.
    ##
    ## Available on: macosx.

  proc play_sound*(soundType = defaultBeep): float64 {.discardable.}
    ## Tries to play a sound provided by your OS.
    ##
    ## May stop playing if your process exits in the meantime. For this reason
    ## the proc returns the amount of seconds you have to wait for the sound to
    ## fully play out in case you want to wait for it.
    ##
    ## Returns a negative value if for some reason the sound could not be loaded
    ## or played back to the user. In most cases this would mean your OS is not
    ## supported because sounds typically have a hardcoded path which may change
    ## on newer versions. Just in case file a bug report.
    ##
    ## Available on: macosx.

  proc play_sound*(filename: string): float64 {.discardable.}
    ## Tries to play any random file supported by your OS.
    ##
    ## May stop playing if your process exits in the meantime. For this reason
    ## the proc returns the amount of seconds you have to wait for the sound to
    ## fully play out in case you want to wait for it.
    ##
    ## Returns a negative value if for some reason the sound could not be loaded
    ## or played back to the user.
    ##
    ## Available on: macosx.

  proc get_clipboard_string*(): string
    ## Returns the contents of the OS clipboard as a string.
    ##
    ## Returns nil if the clipboard can't be accessed or it's not supported.
    ##
    ## Available on: linux, macosx.

  proc set_clipboard*(text: string)
    ## Sets the OS clipboard to the specified text.
    ##
    ## The text has to be a valid value, passing ``nil`` will assert in debug
    ## builds and crash in release builds.
    ##
    ## Available on: macosx.

  proc get_clipboard_change_timestamp*(): int
    ## Returns an integer representing the last version of the clipboard.
    ##
    ## There is no way to get notified of clipboard changes, you need to poll
    ## yourself the clipboard. You can use this proc which returns the last
    ## value of the clipboard, then compare it to future values.
    ##
    ## Note that a change of the timestamp doesn't imply a change of
    ## *contents*.  The user could have well copied the same content into the
    ## clipboard.
    ##
    ## Available on: macosx.
else: ## nimdoc
  when defined(macosx):
    {.passL: "-framework AppKit".}
    {.compile: "genieos_pkg/genieos_macosx.m".}
    proc genieosMacosxNimRecycle(filename: cstring): int {.importc, nodecl.}
    proc genieosMacosxBeep() {.importc, nodecl.}
    proc genieosMacosxPlayAif(filename: cstring): cdouble {.importc.}
    proc genieosMacosxClipboardString(): cstring {.importc.}
    proc genieosMacosxClipboardChange(): int {.importc.}
    proc genieosMacosxSetClipboardString(s: cstring) {.importc.}
  
    proc play_sound*(filename: string): float64 =
      assert(not filename.is_nil)
      if filename.exists_file:
        result = genieosMacosxPlayAif(filename)
      else:
        result = -1
  
    proc play_sound*(soundType = defaultBeep): float64 =
      case soundType
      of defaultBeep:
        genieosMacosxBeep()
        result = 0.150
        return
      of recycleBin:
        # Path to recycle sounds from http://stackoverflow.com/a/9159760/172690
        let
          f1 = "/System/Library/Components/CoreAudio.component/" &
            "Contents/SharedSupport/SystemSounds/dock/drag to trash.aif"
          f2 = "/System/Library/Components/CoreAudio.component/" &
            "Contents/Resources/SystemSounds/drag to trash.aif"
        if existsFile(f1):
          result = f1.play_sound
        elif existsFile(f2):
          result = f2.play_sound
        else:
          result = -1
  
    proc recycle*(filename: string) =
      let result = genieosMacosxNimRecycle(filename)
      if result != 0:
        raise new_exception(OSError,
          "error " & $result & " recycling " & filename)
  
    proc get_clipboard_string*(): string =
      let cresult = genieosMacosxClipboardString()
      if not cresult.isNil():
        result = $cresult
  
    proc get_clipboard_change_timestamp*(): int =
      result = genieosMacosxClipboardChange()
  
    proc set_clipboard*(text: string) =
      assert (not text.isNil())
      genieosMacosxSetClipboardString(cstring(text))
  
  when defined(Linux):
    import x, xlib, xatom
    proc get_clipboard_string*: string =
      result = newStringOfCap(512)
      const
        BUFSIZ = 2048 # missing from x headers? i found it on the internet
      var
        clip,utf8,ty: TAtom
        dpy: PDisplay
        win: TWindow
        ev: TXEvent
        fmt: cint
        off = 0.clong
        data: ptr cuchar
        len,more: culong
      
      dpy = XOpenDisplay(nil)
      if dpy.isNil: return
      
      utf8 = XInternAtom(dpy,"UTF8_STRING",0)
      clip = XInternAtom(dpy,"__MY_STR",0)
      win = XCreateSimpleWindow(dpy, defaultRootWindow(dpy), 0,0,1,1,0,
        CopyFromParent, CopyFromParent)
      
      discard XConvertSelection(dpy, XA_PRIMARY, utf8, clip, win, CurrentTime)
      discard XNextEvent(dpy, ev.addr)
      
      if ev.theType == SelectionNotify:
        let sel = cast[PXSelectionEvent](ev.addr)
        if sel.property != None:
          while true:
            discard XGetWindowProperty(
              dpy, win, sel.property, off, BUFSIZ.clong,
              0.TBool, utf8, ty.addr, fmt.addr, len.addr,
              more.addr, data.addr)
            let newLen = off.int + len.int
            if result.len < newLen:
              result.setLen newLen
            copyMem result[off.int].addr, data, len.int
            
            discard XFree(data)
            off += len.clong
            if more.int < 1:
              break
      
      discard XCloseDisplay(dpy)
