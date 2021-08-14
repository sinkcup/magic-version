setup() {
    load 'test_helper/common-setup'
    _common_setup
    export CI_ENV_FILE="/tmp/coding.env"
    export GIT_COMMIT_SHORT=3a11e12
    export GITHUB_REF=""
}

@test "tag name" {
    export TAG_NAME=1.2.0
    run magic-version.sh
    assert_output '1.2.0'
}

@test "branch" {
    export BRANCH_NAME=feature/login
    run magic-version.sh
    assert_output 'feature-login-3a11e12'
}

@test "merge request" {
    export CHANGE_ID=123
    run magic-version.sh
    assert_output 'mr-123-3a11e12'
}

@test "not env" {
    run magic-version.sh
    assert_output --partial "env variables not found"
}
