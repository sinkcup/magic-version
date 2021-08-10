setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'

    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    # make executables in src/ visible to PATH
    PATH="$DIR/../src:$PATH"
}

@test "use tag name" {
    export TAG_NAME=1.2.0
    run magic-version.sh
    assert_output '1.2.0'
}

@test "use branch" {
    export BRANCH_NAME=feature/login
    export GIT_COMMIT_SHORT=3a11e12
    run magic-version.sh
    assert_output 'feature-login-3a11e12'
}

@test "check env file" {
    export TAG_NAME=1.2.0
    export CI_ENV_FILE="/tmp/.env"
    rm -f $CI_ENV_FILE
    run magic-version.sh
    assert_output --partial '1.2.0'
    run cat $CI_ENV_FILE
    assert_output --partial 'MAGIC_VERSION=1.2.0'
}
