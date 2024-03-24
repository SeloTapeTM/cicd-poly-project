pipeline {
    agent any
    options {
        timestamps()
    }

    environment {
        DH_NAME = "selotapetm"
        FULL_VER = "0.0.$BUILD_NUMBER"
        IMAGE_NAME = "polybot-cicd-prod"
    }
    stages {
        stage('Build') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')])
                {
                    sh '''
                    cd polybot
                    docker login -u $USERNAME -p $PASSWORD
                    docker build -t $DH_NAME/$IMAGE_NAME:$FULL_VER .
                    docker push $DH_NAME/$IMAGE_NAME:$FULL_VER
                    '''
                }
            }
        }
        stage('Trigger Release') {
            steps {
                build job: 'release-prod', wait: false, parameters: [
                    string(name: 'PROD_IMAGE_URL', value: "$DH_NAME/$IMAGE_NAME:$FULL_VER")
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