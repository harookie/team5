pipeline {
    agent any
    environment {
        REGISTRY = "k8s-vga-master:5000"
        IMAGE_NAME = "my-app"
        IMAGE_TAG = "latest"
        NAMESPACE = "team5"
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/harookie/team5.git'  // GitHub에서 코드 가져오기
            }
        }
        stage('Build Image') {
            steps {
                script {
                    sh "docker build -t ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }
        }
        stage('Push Image') {
            steps {
                script {
                    sh "docker push ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh "kubectl set image deployment/my-app my-app=${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} --namespace=${NAMESPACE}"
                }
            }
        }
    }
}
