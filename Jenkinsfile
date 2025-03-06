pipeline {
    agent {
        docker {
            image 'sudipta244/docker-agent-alipne:v2'
            args '--user root -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        AWS_REGION = 'us-east-1'
        ECR_REPOSITORY = 'java/spring-boot'
        AWS_ACCOUNT_ID = '365657944743'

    stages {
        stage('checkout') {
            steps {
                sh 'echo passed'
                // git clone https://github.com/sudipta1/Spring-boot-Project.git
                sh 'ls -lR'
            }
        }
        stage('build and test') {
            steps {
                sh 'ls -ltr'
                sh 'cd Spring-boot-Project && mvn clean install'
            }
        }
    //     stage('static code analysis') {
    //         environment {
    //             SONAR_URL = 'http://localhost:9000'
    //         }
    //         steps {
    //             withcredentials([string(credentialsID:sonarqube, variable: 'SONAR_TOKEN')]) {
    //                 sh 'cd Spring-boot-Project && mvn sonar:sonar -Dsonar.host.url=$SONAR_URL -Dsonar.login=$SONAR_TOKEN'
    //         }
    //     }
    // }

        stage('Configure AWS CLI') {
            withcredentials([string(credentialsID: 'aws-credentials', usernameVariable: AWS_ACCESS_KEY_ID, passwordVariable: AWS_SECRET_ACCESS_KEY)]) {
                sh 'aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID'
                sh 'aws configure set aws_secret_access_key_id $AWS_SECRET_ACCESS_KEY'
                sh 'aws configure set default.region $AWS_REGION'
            }
        }

        stage('Login to ECR') {
            steps {
                sh 'aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com'
            }
        }

        stage('Build and Push Image') {
            environment {
                IMAGE_TAG = 'java/spring-boot:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/java/spring-boot:$BUILD_NO'
            }
           steps {
            sh 'cd Spring-boot-Project && docker build -t $IMAGE_TAG .'
            sh 'docker push $IMAGE_TAG'
           } 

        }

}