# magic-version

[![CI](https://github.com/sinkcup/magic-version/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/sinkcup/magic-version/actions/workflows/ci.yml)

calculate version for CI (CODING/Jenkins, GitHub Actions)

when   | version
-------|---------
tag    | 1.2.0
branch | main-3a11e12
MR     | mr-123-3a11e12

## CODING and Jenkins

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
