# magic-version

[![Test](https://github.com/sinkcup/magic-version/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/sinkcup/magic-version/actions/workflows/ci.yml)

calculate version for CI (CODING, GitHub Actions, Jenkins)

when   | version
-------|---------
tag    | 1.2.0
branch | main-3a11e12
MR     | mr-123-3a11e12
PR(GitHub) | pr-123-3a11e12

if git tag has prefix(eg. `v1.2.0`), set env `TAG_PREFIX = v`, then the program will output version `1.2.0`.

## GitHub

demo: [![CI](https://github.com/sinkcup/magic-version-demo/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/sinkcup/magic-version-demo/actions/runs/1119480527)

```yaml
steps:
  - name: Magic Version
    uses: sinkcup/magic-version@v1
    env:
      TAG_PREFIX: v # optional

  - name: Upload Artifact
    uses: actions/upload-artifact@v2
    with:
      name: demo-${{ env.MAGIC_VERSION }}
      path: dist
```

## CODING

```groovy
stage('pack') {
  environment {
    TAG_PREFIX = 'v'
  }
  steps {
    useCustomStepPlugin(key: 'magic-version', version: 'latest')
    script {
      readProperties(file: env.CI_ENV_FILE).each {key, value -> env[key] = value }
    }
    echo "${env.MAGIC_VERSION}"
  }
}
```

## Jenkins

```groovy
stage('pack') {
  environment {
    TAG_PREFIX = 'v'
  }
  steps {
    // sh 'curl -sLo- http://get.bpkg.sh | bash' // install bpkg
    // sh 'clib install bpkg/bpkg' // install bpkg
    sh 'bpkg install sinkcup/magic-version'
    script {
        magic_version = sh(script:'./deps/bin/magic-version', returnStdout: true).trim()
    }
    echo "${magic_version}"
  }
}
```
