#!/usr/bin/env bash

if [ -z "$TAG_NAME" ]
then
  MAGIC_VERSION=${BRANCH_NAME//\//-}-"$GIT_COMMIT_SHORT"
else
  MAGIC_VERSION="$TAG_NAME"
fi
echo "$MAGIC_VERSION"
