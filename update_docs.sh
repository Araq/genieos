#!/bin/sh

set -e

CURRDIR=`pwd`
rm -Rf docs-*
for VERSION in master `git tag -l`; do
	TMPDIR=/tmp/genieos-docs-$VERSION
	DESTDIR=docs-$VERSION
	rm -Rf $TMPDIR
	rm -Rf $DESTDIR
	mkdir -p $TMPDIR
	(git archive $VERSION | tar -xC $TMPDIR)
	cd $TMPDIR
	nimrod doc2 genieos.nim
	cd "${CURRDIR}"
	mkdir $DESTDIR
	cp $TMPDIR/genieos.html $DESTDIR
	git add docs-*
	git status
	echo "Finished updating docs, please remember to add the link to index.html!"
done
