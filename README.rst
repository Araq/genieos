==================
Nim genieos module
==================

`Nim <http://nim-lang.org>`_ provides the `os module
<http://nim-lang.org/os.html>`_ with OS related procs to manage files among
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

You could copy the `genieos.nim <genieos.nim>`_ file and `genieos_pkg
<genieos_pkg>`_ directory to your project or put these somewhere safe and use
`Nim's configuration files
<http://nim-lang.org/nimc.html#configuration-files>`_ feature to specify their
path. But that would be really raw, like asking `Jessica
<http://en.wikipedia.org/wiki/Jessica_Jung>`_ to eat a cucumber (`she dislikes
them! <http://www.youtube.com/watch?v=TUR7CuD_1zQ>`_). So you can use `Nim's
Nimble package manager <https://github.com/nim-lang/nimble>`_ and type::

    $ nimble update
    $ nimble install genieos


Development version
-------------------

Use `Nim's Nimble package manager <https://github.com/nim-lang/nimble>`_ to
install locally the github checkout::

    $ nimble update
    $ git clone https://github.com/gradha/genieos.git
    $ cd genieos
    $ nimble install -y

Alternatively you can use the following syntax to ask Nimble to install the
development version directly::

    $ nimble update
    $ nimble install -y genieos@#head

Usage
=====

Once you have installed the package you can ``import genieos`` in your programs
and access the exported procs.

The ``genieos`` module comes with embedded docstrings.  `Sooyoung
<http://en.wikipedia.org/wiki/Sooyoung>`_ recommends you to go to
`http://gradha.github.io/genieos/ <http://gradha.github.io/genieos/>`_, there
you will find the generated documentation for all public API versions.


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
reason <http://en.wikipedia.org/wiki/Windows_8>`_. Note how I carefully avoided
any mention of snakes and dongles here... *oops*.

Anyway, this is the stable version 9.4.2. For a list of changes `see the
docs/CHANGES.rst file <docs/CHANGES.rst>`_.


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
time to `Nim's forums <http://forum.nim-lang.org>`_ where you can talk to other
*more serious* Nim programmers.
