pipeline {
    
    agent {
        label 'agent_1'
    }
    
    tools {
          maven 'MAVEN3'
          jdk 'JDK8'
    }
    
    options {
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10')
        disableConcurrentBuilds()
        timestamps()
    }
    
    parameters {
        string defaultValue: '', description: 'Version of the java application', name: 'app_version', trim: false
        choice choices: ['DEV', 'QA', 'INT', 'PRE_PROD'], description: 'Environment name for the code deployment', name: 'APP_ENV'
    }
    
    stages {
        stage('Code Checkout'){
            steps {
                echo "code checkout"
                git credentialsId: 'github-creds', url: 'https://github.com/gkdevops/PetClinic.git'
            }
        }
        
        stage('Code Build'){
            steps {
                sh "mvn test-compile"
            }
        }
                stage('Unit test') {
                    steps {
                        sh "mvn test"
                    }
                }
        stage('SonarQube Scan'){
          environment {
            SCANNER_HOME = tool 'sonar_scanner'
          }
          steps {
            withSonarQubeEnv (installationName: 'SonarQube') {
              sh "${SCANNER_HOME}/bin/sonar-scanner -Dproject.settings=sonar-project.properties"
            }
          }
        }
        stage("Quality Gate") {
            steps {
                timeout(time: 1, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
        stage('Code Package'){
            steps {
                sh "mvn package"
            }
        }
    }
}
