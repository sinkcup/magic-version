setup() {
    load 'test_helper/common-setup'
    _common_setup
    export GITHUB_ENV="/tmp/github.env"
    rm -f $GITHUB_ENV
    export GITHUB_SHA=3a11e12fa7ac8ade4ecb9a779bbb04f788f2ae63
}

@test "tag name" {
    export GITHUB_REF=refs/tags/1.2.0
    run magic-version.sh
    assert_output --partial '1.2.0'
    run cat $GITHUB_ENV
    assert_output --partial 'MAGIC_VERSION=1.2.0'
}

@test "branch" {
    export GITHUB_REF=refs/heads/feature/login
    run magic-version.sh
    assert_output 'feature-login-3a11e12'
    run cat $GITHUB_ENV
    assert_output --partial 'MAGIC_VERSION=feature-login-3a11e12'
}

@test "pull request" {
    export GITHUB_REF=refs/pull/123/merge
    run magic-version.sh
    assert_output 'pr-123-3a11e12'
}
