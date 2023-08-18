// Building docker image and pushing to dockerhub
pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        APP-NAME = "noodejs-static-app"
        IMAGE_TAG = "${env.BUILD_ID}-${env.GIT_COMMIT}"
    }
    stages {
        stage('Build') {
            steps {
                echo 'Building the app'
                sh "docker build -t ${DOCKERHUB_CREDENTIALS_USR}/${APP-NAME}:${IMAGE_TAG} ."
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
                sh "docker push ${DOCKERHUB_CREDENTIALS_USR}/${APP-NAME}:${IMAGE_TAG}"
            }
        }
    }
    post {
        always {
            sh 'docker logout'
        }
    }
}