pipeline {
    agent any
    options {
        timestamps()
    }

    environment {
        DH_NAME = "selotapetm"
        FULL_VER = "0.2.$BUILD_NUMBER"
        IMAGE_NAME = "polybot-cicd-dev"
    }
    stages {
        stage('Build') {
            steps {
                withDockerRegistry(credentialsId: 'dockerhub', url: 'registry.hub.docker.com') {
                    docker.build("${env.DH_NAME}/${env.IMAGE_NAME}:${env.FULL_VER}", "-f polybot/Dockerfile ./polybot").push()
                }
//                 withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')])
//                 {
//                     sh '''
//                     cd polybot
//                     docker login -u $USERNAME -p $PASSWORD
//                     docker build -t $DH_NAME/$IMAGE_NAME:$FULL_VER .
//                     docker push $DH_NAME/$IMAGE_NAME:$FULL_VER
//                     '''
//                 }
            }
        }
        stage('Trigger Release') {
            steps {
                build job: 'release-dev', wait: false, parameters: [
                    string(name: 'DEV_IMAGE_URL', value: "$DH_NAME/$IMAGE_NAME:$FULL_VER")
                    ]
                }
            }
    }
    post {
        always {
            sh '''
            docker system prune -a -f --filter "until=24h"
            docker builder prune -a -f --filter "until=24h"
            '''
            cleanWs()
        }
    }
}