# magic-version

[![Test](https://github.com/sinkcup/magic-version/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/sinkcup/magic-version/actions/workflows/ci.yml)

calculate version for CI (CODING, GitHub Actions)

when   | version
-------|---------
tag    | 1.2.0
branch | main-3a11e12
MR     | mr-123-3a11e12
PR(GitHub) | pr-123-3a11e12

## GitHub

demo: [![CI](https://github.com/sinkcup/magic-version-demo/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/sinkcup/magic-version-demo/actions/runs/1119480527)

```yaml
steps:
  - name: Magic Version
    uses: sinkcup/magic-version@v1.1.0

  - name: Upload Artifact
    uses: actions/upload-artifact@v2
    with:
      name: demo-${{ env.MAGIC_VERSION }}
      path: dist
```

## CODING

```groovy
stage('pack') {
  steps {
    useCustomStepPlugin(key: 'magic-version', version: '1.1.0')
    script {
      readProperties(file: env.CI_ENV_FILE).each {key, value -> env[key] = value }
    }
    echo "${env.MAGIC_VERSION}"
  }
}
```
