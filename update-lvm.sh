#!/bin/sh
# Script to checkout LVM2 from git and make attributes for all versions that
# don't have yet.
#
# Author: Elan Ruusamäe <glen@delfi.ee>
#
# Usage:
# - update all versions: ./update-lvm.sh -a
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
git_dir=lvm2/.git

set -e

msg() {
	echo >&2 "$*"
}

# do initial clone or update LVM2 repository
clone_lvm2() {
	if [ ! -d $GIT_DIR ]; then
		msg "Checkout $repo_url"
		install -d $GIT_DIR
		git init
		git remote add origin $repo_url
		git fetch --depth 1 origin $refs --tags
	else
		msg "Update $repo_url"
		git fetch origin $refs --tags
	fi
}

process_lvm2_version() {
	local tag=$1
	msg ""
	msg "Process LVM2 $tag"

	# already present in source tree
	if [ -d lib/lvm/attributes/$tag ]; then
		msg "lib/lvm/attributes/$tag already exists, skip"
		return
	fi

	msg "Checkout LVM2 $tag"
	cd lvm2
	git checkout $tag
	cd ..

	version=$(awk '{print $1}' lvm2/VERSION)
	msg "LVM2 Full Version: $version"
	# skip old "cvs" releases
	case "$version" in
	*-cvs)
		msg "$version is CVS tag, skip"
		return
		;;
	esac

	# already present locally
	if [ -d $version ]; then
		msg "$version exists, skip"
		return
	fi

	./bin/generate_field_data lvm2

	lvm_dir=$version
	attr_dir=lib/lvm/attributes/${lvm_dir%-git}
	if [ -d "$attr_dir" ]; then
		msg "$attr_dir already exists; abort"
		exit 1
	fi
	mv $lvm_dir $attr_dir

	git_branch=LVM-$tag
	git add -A $attr_dir
	git checkout -b $git_branch next
	git commit -am "Added $tag attributes"
}


GIT_DIR=$git_dir clone_lvm2

if [ "$1" = "-a" ]; then
	# obtain all versions
	set -- $(GIT_DIR=$git_dir git tag -l $pattern)
fi

# it shouldn't be exported, but somewhy is. unset
unset GIT_DIR

# process versions specified on commandline,
# otherwise iterate over all LVM2 tags
for tag in "$@"; do
	process_lvm2_version $tag
done
