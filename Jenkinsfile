pipeline {
    agent {
        docker {
            image 'sudipta244/docker-agent-alpine:v2'
            args '--user root -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        AWS_REGION = 'us-east-1'
        ECR_REPOSITORY = 'java/spring-boot'
        AWS_ACCOUNT_ID = '365657944743'
    }

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
                sh 'mvn clean install'
            }
        }
    //     stage('static code analysis') {
    //         environment {
    //             SONAR_URL = 'http://localhost:9000'
    //         }
    //         steps {
    //             withCredentials([string(credentialsId:'sonarqube', variable: 'SONAR_TOKEN')]) {
    //                 sh 'cd Spring-boot-Project && mvn sonar:sonar -Dsonar.host.url=$SONAR_URL -Dsonar.login=$SONAR_TOKEN'
    //         }
    //     }
    // }

        stage('Configure AWS CLI') {
            steps {
            withCredentials([usernamePassword(credentialsId: 'aws-credentials', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                   sh 'aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID'
                   sh 'aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY'
                   sh 'aws configure set region $AWS_REGION'
                }
            }
        }

        stage('Login to ECR') {
            steps {
                sh 'aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com'
            }
        }

        stage('Build and Push Image') {
            environment {
                DOCKER_IMAGE = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}:${BUILD_NUMBER}"
            }
           steps {
            sh 'docker build -t $DOCKER_IMAGE .'
            sh 'docker push $DOCKER_IMAGE'
           }

        }

        stage('Update the Deployment file') {
            environment {

                GIT_REPO = 'Spring-boot-Project'
                GIT_USERNAME = 'sudipta1'
            }
                steps {
                    withCredentials([string(credentialsId: 'sudipta1', variable: 'GITHUB_TOKEN')]) {
                        sh '''
                         git config --global --add safe.directory '*'
                         git config --global user.email "sudipta.nayak@nayak.com"
                         git config --global user.name "Sudipta Nayak"
                         BUILD_NUMBER=${BUILD_NUMBER}
                         sed -i 's/null/${BUILD_NUMBER}/g' deployment.yml
                         git add deployment.yml
                         git commit -m "Updated deployment.yml into version ${BUILD_NUMBER}"
                         git push https://GITHUB_TOKEN@github.com/${GIT_USERNAME}/${GIT_REPO} HEAD:main

                        '''
                    }
                }
            }
        }
    }
