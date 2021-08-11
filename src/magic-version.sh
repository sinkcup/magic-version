#!/usr/bin/env bash

if [ -n "$TAG_NAME" ]; then
  MAGIC_VERSION=${TAG_NAME//\//-}
elif [ -n "$CHANGE_ID" ]; then
  MAGIC_VERSION=mr-${CHANGE_ID}-${GIT_COMMIT_SHORT}
else
  MAGIC_VERSION=${BRANCH_NAME//\//-}-${GIT_COMMIT_SHORT}
fi

echo "$MAGIC_VERSION"
if [ -n "$CI_ENV_FILE" ]; then
  echo "MAGIC_VERSION=$MAGIC_VERSION" >>"$CI_ENV_FILE"
fi
