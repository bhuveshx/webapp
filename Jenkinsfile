pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // 'deploy' uploads to the repo defined in distributionManagement
                bat 'mvn -B -DskipTests clean deploy'
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
