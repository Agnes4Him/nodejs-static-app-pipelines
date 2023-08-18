// Building docker image and pushing to dockerhub
pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
    }
    stages {
        stage('Build') {
            steps {
                echo 'Building the app'
                sh 'docker build -t agnes4im/nodejs-static-app:v1.0 .'
            }
        }
        stage('Login') {
            steps {
                echo 'Login in ...'
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        stage('Push') {
            steps {
                echo 'Pushing ...'
                sh 'docker push agnes4im/nodejs-static-app:v1.0'
            }
        }
    }
    post {
        always {
            sh 'docker logout'
        }
    }
}