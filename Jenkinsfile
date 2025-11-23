pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // Compiles the code and uploads to Nexus
                bat 'mvn -B -DskipTests clean deploy'
            }
        }
        stage('Sonar-Report') {
        steps {
            // Scans code and sends report to localhost:9000
            bat 'mvn sonar:sonar -Dsonar.host.url=http://localhost:9000 -Dsonar.login=admin -Dsonar.password=admin'
        }
        }
        stage('Test') {
            steps {
                // Runs unit tests
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
                // 1. Kill any old running app (ignore error if none running)
                bat 'taskkill /F /IM java.exe || exit 0'
                
                // 2. Start new app and tell Jenkins NOT to kill it
                withEnv(['JENKINS_NODE_COOKIE=dontKillMe']) {
                     bat 'start /B java -jar target/java-webapp-1.0.jar'
                }
            }
        }
    }
}
