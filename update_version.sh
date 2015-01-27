#!/bin/bash
## Usage: ./update_version.sh <version>

set -e

VERSION=$1

if [ -z "$VERSION" ]; then
  echo "You must specify the new version!"
  exit 1
fi

# Update the version shown to users of the web application.
# Note: Mac OS X's sed requires `-i ""` (a zero-length extension, indicating no backup should be made) in order to do in-place substitution.
sed -i "" "s/^\(__version__ = '\)[0-9a-z.]*/\1$VERSION/g" securedrop/version.py

# Update the version of the securedrop-app-code Debian package
sed -i "" "s/^\(Version: \).*/\1$VERSION/" install_files/securedrop-app-code/DEBIAN/control

# Update the version used by Ansible for the filename of the output of the deb building role
sed -i "" "s/^\(securedrop_app_code_version: \"\)[0-9a-z.]*/\1$VERSION/" install_files/ansible-base/host_vars/app.yml

# Update the changelog
# TODO: I think this file is in the wrong place. Ideally you would edit it with dch, but it does not seem to recognize this file even when run in the same directory
vim install_files/securedrop-app-code/usr/share/doc/securedrop-app-code/changelog.Debian

# Commit the change
# Due to `set -e`, providing an empty commit message here will cause the script to abort early.
git commit -a

# Initiate the process of creating a signed tag, using the workflow for signing with the airgapped signing key.
git tag -a $VERSION

$TAGFILE=$VERSION.tag
git cat-file tag $VERSION > $TAGFILE

echo
echo "[ok] Version update complete and committed."
echo "     Please continue the airgapped signing process with $TAGFILE".
echo
