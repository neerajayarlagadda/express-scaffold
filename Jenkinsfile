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

//     stage('Logging into AWS ECR') {
//             steps {
//                steps {
//             withAWS(credentials: 'aws-credentials', region: 'ap-south-1') {
//             sh "aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 818845199322.dkr.ecr.ap-south-1.amazonaws.com"
//             }    
// //                 //withCredentials([<object of type com.cloudbees.jenkins.plugins.awscredentials.AmazonWebServicesCredentialsBinding>])
// //                 withCredentials([[
// //                     $class: 'AmazonWebServicesCredentialsBinding',
// //                     credentialsId: "aws-credentials",
// //                     accessKeyVariable: 'AWS_ACCESS_KEY_ID',
// //                     secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
// //                 ]])                
//             }
//         }
//     }  
    //        // Uploading Docker images into AWS ECR
    // stage('Pushing to ECR') {
    //  steps{  
    //      script {
    //            script {
    //             sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:$IMAGE_TAG"
    //             sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
    //      }
    //      }
    //     }
    //   }
        
        stage('Push Docker image to ECR') {
            steps {
            withAWS(credentials: 'aws-credentials', region: 'ap-south-1') {
            sh "aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 818845199322.dkr.ecr.ap-south-1.amazonaws.com"
                
            sh "docker build -t neeraja-express-scaffold-test ."

            sh "docker tag neeraja-express-scaffold-test:latest 818845199322.dkr.ecr.ap-south-1.amazonaws.com/neeraja-express-scaffold-test:latest"

            sh "docker push 818845199322.dkr.ecr.ap-south-1.amazonaws.com/neeraja-express-scaffold-test:latest"
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
