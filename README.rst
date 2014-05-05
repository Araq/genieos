Nimrod genie os module
======================

`Nimrod <http://nimrod-lang.org>`_ provides the `os module
<http://nimrod-lang.org/os.html>`_ with OS related procs to manage files among
other things. But this is really just basic POSIX stuff, and nowadays OSes have
things like recycle bins and speakers to play sounds.  However, these kind of
procs are not very cross platform and some people wouldn't like them in the
base os module.

So here's my answer, **genieos** contains several procs which are *too awesome*
to be included in the standard os one. You could actually think of this module
as a *fancy os module*, but if we are talking about fancy stuff, you can't get
more fancy than `Girls' Generation 소녀시대
<http://en.wikipedia.org/wiki/Girls'_Generation>`_, also known as `Sonyeo
Shidae <http://www.youtube.com/watch?v=EOWrdo1kVYw>`_ or `SNSD
<http://www.youtube.com/watch?v=fYP_3QEb5Yk>`_. Just `tell them your wish
<http://www.youtube.com/watch?v=6SwiSpudKWI>`_, you never know what this module
could do for you (hey, `it even remixes well!
<https://soundcloud.com/randommixchannel/luckygenie>`_).



License
=======

`Seohyun <http://en.wikipedia.org/wiki/Seohyun>`_ says this has a `MIT license
<LICENSE.rst>`_.


Installation and usage
======================

Stable version
--------------

You could copy the `genieos.nim <genieos.nim>`_ file and `private <private>`_
directory to your project or put these somewhere safe and use `nimrod's
configuration files <http://nimrod-lang.org/nimrodc.html#configuration-files>`_
feature to specify their path. But that would be really raw, like asking
`Jessica <http://en.wikipedia.org/wiki/Jessica_Jung>`_ to eat a cucumber (`she
dislikes them! <http://www.youtube.com/watch?v=TUR7CuD_1zQ>`_). So you can use
`Nimrod's babel package manager <https://github.com/nimrod-code/babel>`_ and
type::

    babel update
    babel install genieos


Development version
-------------------

Use `Nimrod's babel package manager <https://github.com/nimrod-code/babel>`_ to
install locally the github checkout::

    $ babel update
    $ git clone https://github.com/gradha/genieos.git
    $ cd genieos
    $ babel install -y

Alternatively you can use the following syntax to ask babel to install the
development version::

    $ babel update
    $ babel install -y genieos#head

Usage
=====

Once you have installed the package you can ``import genieos`` in your programs
and access the exported procs.


Documentation
=============

The genieos module comes with embedded docstrings.  `Sooyoung
<http://en.wikipedia.org/wiki/Sooyoung>`_ recommends you to run the ``doc``
`nakefile task <https://github.com/fowlmouth/nake>`_ to obtain the HTML
reference file with instructions on the exported symbols. Unix example::

    $ cd `babel path genieos`
    $ nake doc
    $ open docindex.html

The `docindex file <docindex.rst>`_ links all the available documentation.
Generated documentation for all public API versions can also be found at
`http://gradha.github.io/genieos/ <http://gradha.github.io/genieos/>`_.  No
guarantees on its freshness, though, do check the generation date at the
bottom.


Extra binaries
==============

To put the *awesome* procs into use there's a **trash** command which works
like your typical **rm** from the command line but instead of removing files it
puts them nicely in your recycle bin. Check out the `trash-binary directory
<trash-binary>`_ for further information.


Roadmap
=======

This module implements MacOSX functionality, a toy OS `Sunny
<http://en.wikipedia.org/wiki/Sunny_(singer)>`_ would enjoy using. *Real men*
with *real operative systems*, however, are presumed to step in at some point
and implement these procs (or add new ones) to their *manly platforms*.
Unfortunately they are `figuring out where the recycle bin is
<http://stackoverflow.com/a/6807599/172690>`_ or `cleaning tiles for some
reason <http://en.wikipedia.org/wiki/Windows_8>`_.

Note how I carefully avoided any mention of snakes and dongles here... *oops*.
Anyway, `the latest version is 9.3.1 <docs/CHANGES.rst>`_.


Git branches
============

This project uses the `git-flow branching model
<https://github.com/nvie/gitflow>`_ with reversed defaults. Stable releases are
tracked in the ``stable`` branch. Development happens in the default ``master``
branch.


Feedback
========

You can send me feedback through `github's issue tracker
<https://github.com/gradha/genieos/issues>`_. I also take a look from time to
time to `Nimrod's forums <http://forum.nimrod-lang.org>`_ where you can talk to
other *more serious* nimrod programmers.
