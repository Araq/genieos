What to do for a new public release?
====================================

* Create new milestone with version number.
* Create new dummy issue *Release versionname* and assign to that milestone.
* git flow release start versionname (versionname without v but including SNSD
  member, like ``9.1.2-sunny``).
* Update version numbers:

  * Modify `../README.rst <../README.rst>`_.
  * Modify `../genieos.nim <../genieos.nim>`_.
  * Modify `../genieos.babel <../genieos.babel>`_.
  * Update `CHANGES.rst <CHANGES.rst>`_ with list of changes and
    version/number.

* ``git commit -av`` into the release branch the version number changes.
* ``git flow release finish versionname`` (the tagname is versionname without v
  but including SNSD member, like ``9.1.2-sunny``).
* Move closed issues from "*future milestone*" to the release milestone.
* Push all to git: ``git push origin master stable --tags``.
* Increase version const number in main module, at least maintenance (stable
  version + 0.1.1):

  * Modify `../README.rst <../README.rst>`_.
  * Modify `../genieos.nim <../genieos.nim>`_.
  * Modify `../genieos.babel <../genieos.babel>`_.
  * Update `CHANGES.rst <CHANGES.rst>`_ development version with unknown date.

* ``git commit -av`` into master with *Bumps version numbers for development
  branch. Refs #release issue*.
* Close the dummy release issue.
* Check out gh-pages branch and run update script.
* Add to the index.html the link of the new version along with files.
* Push docs.
* Announce at http://forum.nimrod-code.org/t/143.
