pipeline {
    agent any

    stages {
        stage('Deploy') {
            steps {
                // 1. Kill any old running app (ignore error if none running)
                bat 'taskkill /F /IM java.exe || exit 0'
                
                // 2. Start new app and tell Jenkins NOT to kill it
                withEnv(['JENKINS_NODE_COOKIE=dontKillMe']) {
                     bat 'start /B java -jar target/java-webapp-1.0.jar'
                }
            }
        }

        stage('Test') {
            steps {
                bat 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }

        stage('Deploy') {
            steps {
                // Windows equivalent of 'nohup' to run in background
                // 'start /B' runs it without opening a new window
                bat 'start /B java -jar target/java-webapp-1.0.jar'
            }
        }
    }
}
