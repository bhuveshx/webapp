pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // 1. STOP OLD APP FIRST: Frees the JAR file so Maven can delete it
                bat 'taskkill /F /IM java.exe || exit 0'
                
                // 2. Build and Upload to Nexus
                bat 'mvn -B -DskipTests clean deploy'
            }
        }

        stage('Sonar-Report') {
            steps {
                     bat 'mvn sonar:sonar -Dsonar.host.url=http://127.0.0.1:9000 -Dsonar.login=admin -Dsonar.password=admin'
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
                // 4. Start the new version and keep it running
                withEnv(['JENKINS_NODE_COOKIE=dontKillMe']) {
                     bat 'start /B java -jar target/java-webapp-1.0.jar'
                }
            }
        }
    }
}
