pipeline {
    agent {
        label 'Slave-01'
    }
    stages {
        stage('Build') {
            steps {
            // 'deploy' uploads to the repo defined in distributionManagement
            sh 'mvn -B -DskipTests clean deploy'
            }
        }
//         stage('Sonar-Report') {
//             steps {
//             sh 'mvn sonar:sonar \
//   -Dsonar.projectKey=jenkins_project \
//   -Dsonar.host.url=http://localhost:9000 \
//   -Dsonar.login=5f09ded7e5db4d0ea0dcfd937c181af706e60475'
//             }
//         }
        stage('Test') { 
            steps {
                sh 'mvn test' 
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml' 
                }
            }
        }
//        stage('Sonar-Report') {
//          steps {
//              sh 'mvn clean install sonar:sonar -Dsonar.host.url=http://localhost:9000 -Dsonar.analysis.mode=publish'
//          }
//     }
        stage('Deploy') {
    steps {
        sh 'nohup java -jar target/java-webapp-1.0.jar &'
    }
}
    }
}
