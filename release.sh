#!/usr/bin/env bash
# -eE sets the bash environment tostop if any command gives a non 0 return
# and launches the trap
set -eE
trap "echo Error!" ERR

# docker credentials
USERNAME=charckle
IMAGE=tailon

echo "pulling latest image from git"
git pull

# bump version
OLD_VERSION=$(cat VERSION)
echo "Bumping version from $OLD_VERSION"
docker run --rm -v "$PWD":/app treeder/bump patch
version=$(cat VERSION)
echo "version: $version"

# now run build
# build will create the latest image, and the version image, and push both to docker
. build.sh

# now make tags and push it to git
echo "Adding tags to git and pushing"
git add .
git commit -m "version $version"
git push
git push --tags
