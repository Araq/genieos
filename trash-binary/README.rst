trash
=====

No, no, not that this is trash. As `Hyoyeon
<http://en.wikipedia.org/wiki/Kim_Hyo-yeon>`_ correctly points out, this is
just a MacOSX command line tool using `the genieos module <../genieos.nim>`_
for the `Nimrod programming language <http://nimrod-lang.org>`_. This tool can
be used instead of the typical ``rm`` command found on many Unix systems, and
instead of vanishing your files it will move them to the recycle bin, even
making the Dock's recycle bin sound (you can optionally disable this).


Installation and usage
======================

If you have Nimrod and the ``genieos`` module, you can simply type::

    nimrod c -d:release trash.nim

This will generate a ``trash`` binary of more or less 150KB which you can put
somewhere in your ``PATH`` and happily use. If you really care about size, you
can use `the ultimate packer for executables <http://upx.sourceforge.net>`_
like ``upx --best trash`` to reduce it further to about 52KB. Oh, I nearly
forgot.  For commandline parsing this command uses the `argument_parser module
<https://github.com/gradha/argument_parser>`_) which you previously have to
install through `Nimrod's babel package manager
<https://github.com/nimrod-code/babel>`_ typing::

    babel install argument_parser


Documentation
=============

According to
`Tiffany <http://en.wikipedia.org/wiki/Tiffany_(South_Korean_singer)>`_ there's
not much documentation for this simple tool. You should run the command with
the ``-h`` or ``--help`` parameters to see its options.


Benchmarks
==========

Because a commandline tool for moving files to the recycle bin without
unscientific benchmarks would be like a day without watching `Yuri
<http://en.wikipedia.org/wiki/Kwon_Yuri>`_ dance, here's a comparison to other
MacOSX programs with similar functionality: `rmtrash
<http://www.nightproductions.net/cli.htm>`_, `rm-trash.py
<https://github.com/albertz/helpers/blob/master/rm-trash.py>`_ and `osx-trash
<http://www.dribin.org/dave/osx-trash/>`_.

Let's run our nimrod binary to set as baseline::

    [0:gradha@amber.local:0] [/tmp]$ time (touch 1.delete; \
        mkdir 2.delete; trash ?.delete)
    real	0m0.980s
    user	0m0.076s
    sys	0m0.060s

Huh, so nearly a second to remove one file and a directory. Let's see how the
Ruby script performs (Ruby's osx-trash package provides a *binary* with the
same ``trash`` name so I only renamed it, no hard feelings)::

    [0:gradha@amber.local:0] [/tmp]$ time (touch 1.delete; \
        mkdir 2.delete; rubytrash ?.delete)
    real	0m2.678s
    user	0m0.665s
    sys	0m0.174s

Ugh, so it takes nearly three times as long. Ok, let's try the python version::

    [0:gradha@amber.local:0] [/tmp]$ time (touch 1.delete; \
        mkdir 2.delete; ./rm-trash.py ?.delete)
    real	0m0.636s
    user	0m0.183s
    sys	0m0.097s

That's more like it, improving over our own nimrod version! For completeness
let's run the objc implementation, which should be the fastest one, given that
we are trying to execute an objc/Cocoa API here::

    [0:gradha@amber.local:0] [/tmp]$ time (touch 1.delete; \
        mkdir 2.delete; ./rmtrash ?.delete)
    real	0m0.077s
    user	0m0.011s
    sys	0m0.012s

Yay, impressive performance. But wait a sec, I was listening to
`Yoona <http://en.wikipedia.org/wiki/Im_Yoona>`_ singing a solo and noticed a
lack of sounds over her beautiful voice! If you repeat these commands on your
machine you should hear the ruby and nimrod version triggering the recycle bin
sound but not so for the objc or python version.

Oh, look at this, if you actually read their implementation they are **not
using** the proper recycle bin API, instead ``rm-trash`` is simply moving the
files to the path where the MacOSX recycle bin just happens to be located,
which is presumably bad and prone to breakage and doesn't trigger the
user-friendly sound confirming the action. The python script is calling an objc
API, but that API `FSPathMoveObjectToTrashSync` is deprecated and doesn't
trigger the sound.

Well, that's sort of cheating. I don't want to avoid using the API like
``rm-trash`` since `that doesn't update the .DS_Store file located in the
.Trash folder <http://superuser.com/a/112586/10892>`_, but at least we can put
ourselves more on equal ground by avoiding to play back the recycle bin sound
with the silent ``-s`` parameter::

    [0:gradha@amber.local:0] [/tmp]$ time (touch 1.delete; \
        mkdir 2.delete; trash -s ?.delete)
    real	0m0.099s
    user	0m0.058s
    sys	0m0.026s

Ah, that's much better. Without producing the sound (and waiting for it to play
back) the nimrod version goes under 100ms, much closer to the 77ms of the
cheating objc version. **UPDATE:** after `implementing sound playback in the
background <https://github.com/gradha/genieos/issues/2>`_ the normal command
returns much faster to the foreground, but the external process spawn still
takes some milliseconds.

Ok, that's it. I won't be running this benchmarks in any way or form in the
future since that could generate different results due to the CPU load of my
machine and break my happiness. Simply sleep better knowing `Nimrod is
awesome <http://nimrod-lang.org>`_.
