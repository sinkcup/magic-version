setup() {
    load 'test_helper/common-setup'
    _common_setup
    export GITLAB_CI=true
    export CI_COMMIT_SHORT_SHA=3a11e12
}

@test "tag name" {
    export CI_COMMIT_TAG=1.2.0
    run magic-version.sh
    assert_output --partial '1.2.0'
}

@test "branch" {
    export CI_COMMIT_REF_SLUG=feature-login
    run magic-version.sh
    assert_output 'feature-login-3a11e12'
}

@test "pull request" {
    export CI_MERGE_REQUEST_ID=123
    run magic-version.sh
    assert_output 'mr-123-3a11e12'
}
