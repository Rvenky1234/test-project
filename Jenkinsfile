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
     }
}
