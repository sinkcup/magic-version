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

if [ -n "$GITLAB_CI" ]; then
  GIT_COMMIT_SHORT="$CI_COMMIT_SHORT_SHA"
  TAG_NAME="$CI_COMMIT_TAG"
  CHANGE_ID="$CI_MERGE_REQUEST_ID"
  BRANCH_NAME="$CI_COMMIT_REF_SLUG"
fi

if [ -n "$TAG_NAME" ]; then
  MAGIC_VERSION=${TAG_NAME#*"$TAG_PREFIX"}
elif [ -n "$CHANGE_ID" ]; then
  MAGIC_VERSION=${MERGE_REQUEST_VERSION_PREFIX}-${CHANGE_ID}-${GIT_COMMIT_SHORT}
elif [ -n "$BRANCH_NAME" ]; then
  MAGIC_VERSION=${BRANCH_NAME//\//-}-${GIT_COMMIT_SHORT}
else
  echo -e "\033[31m""env variables not found""\033[0m"
  exit 1
fi

echo "$MAGIC_VERSION"
if [ -n "$CI_ENV_FILE" ]; then
  echo "MAGIC_VERSION=$MAGIC_VERSION" >>"$CI_ENV_FILE"
fi
