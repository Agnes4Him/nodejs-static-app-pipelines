// Building docker image and pushing to Amazon ECR
pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }
    environment {
        AWS_ACCOUNT_ID="759907441676"
        AWS_DEFAULT_REGION="us-east-1" 
        IMAGE_REPO_NAME="nodejs-static-app"
        IMAGE_TAG="${env.BUILD_ID}-${env.GIT_COMMIT}"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }
    stages {
        stage('Build') {
            steps {
                echo 'Building the app'
                sh "docker build -t ${IMAGE_REPO_NAME}:${IMAGE_TAG} ."
            }
        }
        stage('Login') {
            //steps {
                //echo 'Login in ...'
                //sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
            //}
            steps {
                echo 'Login in ...'
                withAWS(credentials: 'aws-creds', region: 'us-east-1') {
                    sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                }
            }
        }
        stage('Push') {
            steps {
                echo 'Pushing ...'
                sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:${IMAGE_TAG}"
                sh "docker push ${REPOSITORY_URI}:${IMAGE_TAG}"
            }
        }
    }
    post {
        always {
            sh 'docker logout'
        }
    }
}