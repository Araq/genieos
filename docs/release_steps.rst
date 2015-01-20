===============================================
What to do for a new public release of genieos?
===============================================

* Create new milestone with version number (vXXX-singer) at
  https://github.com/gradha/genieos/issues/milestones/. Include in the
  milestone description: "In honour of singer-url".
* Create new release issue *Release versionname* and assign to that milestone.
  Repeat link in issue description.
* git flow release start versionname (versionname without v but including SNSD
  member, like ``9.1.2-sunny``).
* Update version numbers:

  * Modify `../README.rst <../README.rst>`_.
  * Modify `../genieos.nim <../genieos.nim>`_.
  * Modify `../genieos.nimble <../genieos.nimble>`_.
  * Update `CHANGES.rst <CHANGES.rst>`_ with list of changes and
    version/number.

* ``git commit -av`` into the release branch the version number changes.
* ``git flow release finish versionname`` (the tagname is versionname without v
  but including SNSD member, like ``9.1.2-sunny``). When specifying the tag
  message, copy and paste a text version of the changes log into the message.
  Add rst item markers.
* Move closed issues to the release milestone.
* ``git push origin master stable --tags``.
* Increase version const number in main module, at least maintenance (stable
  version + 0.0.1):

  * Modify `../README.rst <../README.rst>`_.
  * Modify `../genieos.nim <../genieos.nim>`_.
  * Modify `../genieos.nimble <../genieos.nimble>`_.
  * Update `CHANGES.rst <CHANGES.rst>`_ development version with unknown date.

* ``git commit -av`` into master with *Bumps version numbers for development
  version. Refs #release issue*.
* ``git push origin master stable --tags``.
* Close the release issue.
* Check out ``gh-pages`` branch and run update script.
* Add to the index.html the link of the new version along with files.
* Push docs.
* Announce at http://forum.nimrod-code.org/t/143.
* Close the milestone on github.
