pipeline {

  agent any

  stages {
    stage("Apply OC Build-Time things") {
      steps {
        sh "oc apply -f oc-manifests/build-time/"
      }
    }

    stage("Build Images") {
      steps {
        parallel (
          "hub": {
            script {
              def gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
              def shortCommit = gitCommit.take(8)
              openshiftBuild(
                bldCfg: 'selenium-hub',
                showBuildLogs: 'true',
                commit: shortCommit
              )

              openshiftTag(
                sourceStream: 'selenium-hub',
                sourceTag: 'latest',
                destinationStream: 'selenium-hub',
                destinationTag: shortCommit
              )
            }
          },
          "chrome": {
            script {
              def gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
              def shortCommit = gitCommit.take(8)
              openshiftBuild(
                bldCfg: 'selenium-chrome',
                showBuildLogs: 'true',
                commit: shortCommit
              )

              openshiftTag(
                sourceStream: 'selenium-chrome',
                sourceTag: 'latest',
                destinationStream: 'selenium-chrome',
                destinationTag: shortCommit
              )
            }
          },
          "runner": {
            script {
              def gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
              def shortCommit = gitCommit.take(8)
              openshiftBuild(
                bldCfg: 'selenium-runner',
                showBuildLogs: 'true',
                commit: shortCommit
              )

              openshiftTag(
                sourceStream: 'selenium-runner',
                sourceTag: 'latest',
                destinationStream: 'selenium-runner',
                destinationTag: shortCommit
              )
            }
          }
        )
      }
    }

    stage("Apply OC Run-Time things") {
      steps {
        sh "oc apply -f oc-manifests/run-time/"
      }
    }

    stage("Deploy: Testing ENV") {
      steps {
        parallel (
          "selenium-hub": {
            script {
              openshiftDeploy(
                depCfg: 'selenium-hub'
              )
            }
          },
          "selenium-chrome": {
            script {
              openshiftDeploy(
                depCfg: 'selenium-chrome'
              )
            }
          }
        )
      }
    }

    stage("Run a Selenium test") {
      steps {
        sh "sleep 30 # let the selenium deploy become ready ..."
        sh "oc delete -f oc-manifests/test-time/"
        sh "oc create -f oc-manifests/test-time/"
        sh "sleep 5"
        sh "oc logs -f selenium-runner"
        sh "oc delete -f oc-manifests/test-time/"
      }
    }

  }
}
