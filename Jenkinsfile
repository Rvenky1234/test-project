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
         stage('SonarQube Analysis') {
            agent {
                label 'sonar'
            } 
            steps {
                // Use the SonarQube environment
            script{
               scannerHome = tool 'sonar-scanner'
                }
                withSonarQubeEnv('sonar_k8s') {
                    // Run the SonarQube scanner
                    sh '/opt/sonar-scanner/bin/sonar-scanner -Dsonar.projectKey=TEST -Dsonar.projectName=TEST -Dsonar.projectVersion=0.1  -Dsonar.sources=src '
                }
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
        sh '''#!/bin/bash
            service_status=`helm list | grep -i testing | awk \'{print $8}\'`
            echo "Service Status is $service_status"
            if [ "$service_status" == deployed ]; then
                echo "Service Exist,So upgrade to new version"
                echo "helm upgrade testing --recreate-pods  ./testing/"
                helm upgrade testing --recreate-pods  ./testing/
            elif [ "$service_status" == FAILED ]; then  
                echo "Service Initial Deployment failed, So re-install"
                helm del --purge testing
                helm install testing ./testing/
            else
                echo "Service Not Exist,So first-time Deployment"
                echo "helm install --name testing ./testing/"
                helm install testing ./testing/
                echo "Image Tag is testing"
                fi
                '''
                }
        }    
     }
}
