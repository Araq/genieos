=====================
genieos release steps
=====================

* Create new milestone with version number (vXXX-singer) at
  https://github.com/gradha/genieos/issues/milestones/. Include in the
  milestone description: "In honour of singer-url". Singer names are picked
  from the list mentioned in the `version_str docstring
  <../genieos.html#version_str>`_.
* Create new release issue *Release versionname* and assign to that milestone.
  Repeat link in issue description.
* ``git flow release start versionname`` (versionname without v but including
  SNSD member, like ``9.1.2-sunny``).
* Update version numbers:

  * Modify `../README.rst <../README.rst>`_.
  * Modify `../genieos.nim <../genieos.nim>`_.
  * Modify `../genieos.nimble <../genieos.nimble>`_.
  * Update `CHANGES.rst <CHANGES.rst>`_ with list of changes and
    version/number.

* ``git commit -av`` into the release branch the version number changes.
* ``git flow release finish versionname`` (the tagname is versionname without
  ``v`` but including SNSD member, like ``9.1.2-sunny``). When specifying the
  tag message, copy and paste a text version of the changes log into the
  message.  Add text item markers.
* Move closed issues to the release milestone.
* Increase version const number in main module, at least maintenance (stable
  version + 0.0.1):

  * Modify `../README.rst <../README.rst>`_.
  * Modify `../genieos.nim <../genieos.nim>`_.
  * Modify `../genieos.nimble <../genieos.nimble>`_.
  * Update `CHANGES.rst <CHANGES.rst>`_ development version with unknown date.

* ``git commit -av`` into master with `Bumps version numbers for development
  version. Refs #release issue`.
* Regenerate static website.

  * Make sure git doesn't show changes, then run ``nake web`` and review.
  * ``git add . && git commit``. Tag with
    `Regenerates website. Refs #release_issue`.
  * ``./nakefile postweb`` to return to the previous branch. This also updates
    submodules, so it is easier.

* ``git push origin master stable gh-pages --tags``.
* Close the release issue.
* Close the milestone on github.
* Announce at http://forum.nim-lang.org/t/143.
