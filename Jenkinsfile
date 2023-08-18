// Pull docker image from dockerhub and deploy to EC2
pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }
    environment {
        IMAGE_REPO="agnes4im/nodejs-static-app:v1.0"
    }
    stages {
        stage('Pull Image') {
            steps {
                echo 'Pulling docker image'
                sh "docker pull ${IMAGE_REPO}"
            }
        }
        stage('Deploy Image') {
            steps {
                echo 'Deploying ...'
                def dockerCmd = "docker run -p 5555:5555 -d ${IMAGE_REPO}"
                sshagent(['server-key']) {
                    sh "ssh -o StrictHostKeyChecking=no ubuntu@ip_address ${dockerCmd}"
                }
            }
            /*steps {
                echo 'Deploying ...'
                withAWS(credentials: 'aws-creds', region: 'us-east-1') {
                    def dockerCmd = "docker run -p 5555:5555 -d ${IMAGE_REPO}"
                    sshagent(['server-key']) {
                        sh "ssh -o StrictHostKeyChecking=no ubuntu@ip_address ${dockerCmd}"
                    }
                }
            }*/
        }
    }
}