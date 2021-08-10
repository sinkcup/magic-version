# magic-version

[![CI](https://github.com/sinkcup/magic-version/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/sinkcup/magic-version/actions/workflows/ci.yml)

create version number for CI (CODING, GitHub Actions)

## CODING

```groovy
stage('pack') {
  steps {
    useCustomStepPlugin(key: 'magic-version', version: '1.0.2')
    script {
      readProperties(file: env.CI_ENV_FILE).each {key, value -> env[key] = value }
    }
    echo "${env.MAGIC_VERSION}"
  }
}
```
