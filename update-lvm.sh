#!/bin/sh
# Script to checkout LVM2 from git and make attributes for all versions that
# don't have yet.
#
# Author: Elan Ruusamäe <glen@delfi.ee>
#
# Usage:
# - update all versions: ./update-lvm.sh
# - update specific version "2.0.102": ./update-lvm.sh v2_02_102

# ADDING ATTRIBUTES:
# To add attributes:
# * Download and extract LVM2 source version from: http://git.fedorahosted.org/cgit/lvm2.git/refs/tags
# * Fork this repository
# * `git clone your-forked-repo`
# * `cd your-forked-repo`
# * `git checkout -b mybranch`
# * `bin/generate_field_data path/to/lvm2-source`
#   * See missing attribute type note below if there's issues, otherwise will just return "Done."
# * `mv LVM_VERSION_FULL lib/lvm/attributes/LVM_VERSION`
#   * LVM_VERSION_FULL being something like 2.02.86(2)-cvs or 2.02.98(2)-git
#   * LVM_VERSION being something like 2.02.86(2) or 2.02.98(2)
# * `git commit -am "Added LVM_VERSION attributes"`
# * `git push origin mybranch`
# * Submit PR to this repository. **Please make sure to point your pull at the
#   `next` branch -- NOT MASTER!**
#

repo_url=git://git.fedorahosted.org/git/lvm2.git
refs=refs/heads/master:refs/remotes/origin/master
pattern=v2_02_*

set -e

export GIT_DIR=lvm2/.git

if [ ! -d $GIT_DIR ]; then
	install -d $GIT_DIR
	git init
	git remote add origin $repo_url
	git fetch --depth 1 origin $refs --tags
else
	git fetch origin $refs --tags
fi

# iterate over all tags
for tag in ${@:-$(git tag -l $pattern)}; do
	# already present in source tree
	test -d lib/lvm/attributes/$tag && continue

	echo "Process $tag"
	cd lvm2
	env -u GIT_DIR git checkout $tag
	cd ..

	version=$(awk '{print $1}' lvm2/VERSION)
	# skip old "cvs" releases
	case "$version" in
	*-cvs)
		continue
		;;
	esac

	# already present locally
	test -d $version && continue

	./bin/generate_field_data lvm2 || echo FAILED
done
