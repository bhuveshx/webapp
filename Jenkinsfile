pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // Clean previous build and compile new one
                // Also upload to Nexus
                bat 'mvn -B -DskipTests clean deploy'
            }
        }

        // Uncomment this if you have SonarQube running locally
        // stage('Sonar-Report') {
        //    steps {
        //        bat 'mvn sonar:sonar -Dsonar.host.url=http://127.0.0.1:9000 -Dsonar.login=admin -Dsonar.password=admin'
        //    }
        // }

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

        stage('Deploy to Staging') {
            steps {
                // This sets the cookie so Jenkins doesn't kill the app when the build finishes
                withEnv(['JENKINS_NODE_COOKIE=dontKillMe']) {
                    // Execute the script we created in Step 1
                    bat 'deploy_staging.bat'
                }
            }
        }
    }
}
