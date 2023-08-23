pipeline {
     agent any
     stages {
         stage('Clean Workspace') {
             steps {
                  deleteDir()                  
             }
         }
         stage('Clone Project') {
             steps {                  
                  checkout scm                  
             }
         }
        stage ('JDK_11') {
             tools {
            jdk 'java'
            }
             steps{
               sh '''
              java -version
              '''
            }
        }
       stage ('Build') {
         steps {
           echo "Starting Build"
           sh 'npm install'
           sh 'ng build'
         }
       }
       stage ('Docker') {
         steps{
           echo "Building image"
            sh 'docker build -t images .'   
            }
        }
       stage('Docker push') {
      steps {
        sh'''
          docker login  --username rvenkat1234 --password Venky@007
          docker tag images:latest rvenkat1234/test-project:1
          docker push rvenkat1234/test-project:1
        '''
      }
}
       stage('K8s deploy') {
         steps {
           sh'''
             kubectl apply -f deployment.yaml
             '''
         }
       }
     }
}
