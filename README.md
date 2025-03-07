# Spring-boot Demo Project

Build this project using Jenkins and ArgoCD
This is a demo application where I only have two endpoints 'demo' and 'test'
Built CI on jenkins, used Docker agent for running the pipeline which will use host docker daemon

# Built my own agent Dockerfile and pushed it to Dockerhub: (Has all the dependencies Java, Maven, AWS CLI, Docker CLI installed)

FROM jenkins/inbound-agent:latest                     
USER root                       
**Install Java, Maven, AWS CLI, Docker**                
RUN apt-get update && \              
    apt-get install -y openjdk-17-jdk maven awscli docker.io && \           
    apt-get clean               
**Set Jenkins agent workspace**                
RUN mkdir -p /home/jenkins/agent              
WORKDIR /home/jenkins/agent               
**Switch back to jenkins user**                
USER jenkins              
**Entry point for Jenkins agent**                
ENTRYPOINT ["jenkins-agent"]            

# Defined stages on Jenkinefile
stage1: checkout                                     
stage2 : Build and Test(Maven)                    
stage3: static code analysis(Sonarqube)                
stage4: Configure AWS CLI                
stage4: Login to ECR                
stage5: Build and Push the image into ECR                
stage6: Update the deployment.yml file with new build image                




