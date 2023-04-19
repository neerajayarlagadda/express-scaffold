pipeline {
    agent any
    environment {
        registry = "818845199322.dkr.ecr.ap-south-1.amazonaws.com/neeraja-express-scaffold-test"
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
          dockerImage = docker.build registry
        }
      }
    }
    // Uploading Docker images into AWS ECR
    stage('Pushing to ECR') {
     steps{  
         script {
                sh 'aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 818845199322.dkr.ecr.ap-south-1.amazonaws.com'
                sh '818845199322.dkr.ecr.ap-south-1.amazonaws.com/neeraja-express-scaffold-test:latest'
         }
        }
      }

    // Stopping Docker containers for cleaner Docker run
     stage('stop previous containers') {
         steps {
            sh 'docker ps -f neeraja-express-scaffold-test -q | xargs --no-run-if-empty docker container stop'
            sh 'docker container ls -a -fname=neeraja-express-scaffold-test -q | xargs -r docker container rm'
         }
       }
      
    stage('Docker Run') {
     steps{
         script {
                sh 'docker run -d -p 3000:3000 --rm --name neeraja-express-scaffold-test 818845199322.dkr.ecr.ap-south-1.amazonaws.com/neeraja-express-scaffold-test:latest'
            }
      }
    }
    }
}