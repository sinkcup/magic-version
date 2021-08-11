#!/usr/bin/env bash

MERGE_REQUEST_VERSION_PREFIX="mr"

# refs/heads/feat/feature-branch-1
# refs/tags/v1.3.7
# refs/pull/42/merge
if [ -n "$GITHUB_REF" ]; then
  CI_ENV_FILE="$GITHUB_ENV"
  GIT_COMMIT_SHORT=${GITHUB_SHA:0:7}
  MERGE_REQUEST_VERSION_PREFIX="pr"

  case "$GITHUB_REF" in
    *refs/heads/*)
      BRANCH_NAME=${GITHUB_REF#refs/heads/}
      ;;
    *refs/tags/*)
      TAG_NAME=${GITHUB_REF#refs/tags/}
      ;;
    *refs/pull/*)
      TMP=${GITHUB_REF#refs/pull/}
      CHANGE_ID=${TMP%/*}
      ;;
esac
fi

if [ -n "$TAG_NAME" ]; then
  MAGIC_VERSION=${TAG_NAME//\//-}
elif [ -n "$CHANGE_ID" ]; then
  MAGIC_VERSION=${MERGE_REQUEST_VERSION_PREFIX}-${CHANGE_ID}-${GIT_COMMIT_SHORT}
else
  MAGIC_VERSION=${BRANCH_NAME//\//-}-${GIT_COMMIT_SHORT}
fi

echo "$MAGIC_VERSION"
if [ -n "$CI_ENV_FILE" ]; then
  echo "MAGIC_VERSION=$MAGIC_VERSION" >>"$CI_ENV_FILE"
fi
