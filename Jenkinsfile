pipeline {
    agent { dockerfile true } 
    environment {
        AWS_ACCOUNT_ID="818845199322"
        AWS_DEFAULT_REGION="ap-south-1"
        IMAGE_REPO_NAME="neeraja-express-scaffold-test"
        IMAGE_TAG="v1"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
        
    }
   
    stages {

            stage('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/neerajayarlagadda/express-scaffold.git']]])     
            }
        }
  // Building Docker images
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
        }
      }
    }
  
    }
}
