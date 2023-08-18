// Deploy docker-compose file to EC2
pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }
    stages {
        stage('Deploy') {
            steps {
                script {
                    echo 'Deploying ...'
                    def dockerComposeCmd = "docker-compose -f docker-compose.yaml up -d"
                    sshagent(['server-key']) {
                        sh "scp docker-compose.yaml ubuntu@18.205.2.119:/home/ubuntu"
                        sh "ssh -o StrictHostKeyChecking=no ubuntu@18.205.2.119 ${dockerComposeCmd}"
                    }
                }
            }
        }
    }
}