pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // 1. Kill old app to unlock files
                bat 'taskkill /F /IM java.exe || exit 0'
                // 2. Build & Upload to Nexus
                bat 'mvn -B -DskipTests clean deploy'
            }
        }

        stage('Sonar-Report') {
            steps {
                // 3. Run Analysis (Ensure SonarQube is running on localhost:9000)
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
                // 4. Deploy new version
                withEnv(['JENKINS_NODE_COOKIE=dontKillMe']) {
                     bat 'start /B java -jar target/java-webapp-1.0.jar'
                }
            }
        }
    }
}
