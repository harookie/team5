pipeline {
    agent any
    environment {
        REGISTRY = "k8s-vga-worker1:5000"
        IMAGE_NAME = "team5-app"
        IMAGE_TAG = "latest"
        NAMESPACE = "group1-team5"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/harookie/team5.git'
            }
        }
        stage('Build with Maven') {
            steps {
                script {
                    sh 'mvn clean package -DskipTests'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    sh "docker push ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh "kubectl set image deployment/team5-app team5-app=${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} --namespace=${NAMESPACE}"
                }
            }
        }
    }
}
