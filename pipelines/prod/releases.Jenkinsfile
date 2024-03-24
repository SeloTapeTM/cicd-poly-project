pipeline {
    agent any
    options {
        timestamps()
    }
    parameters { string(name: 'PROD_IMAGE_URL', defaultValue: '', description: '') }


    stages {
        stage('Update YAML') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'github-token', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                    printenv

                    if [[ $PROD_IMAGE_URL == *"polybot-cicd-prod" ]]; then
                        YAML_FILE="k8s/prod/polybot.yaml"
                    elif [[ $PROD_IMAGE_URL == *"yolo-cicd-prod" ]]; then
                        YAML_FILE="k8s/prod/yolo5.yaml"
                    else
                        exit 7
                    fi

                    git config --global user.email "Jenkins@ip-10-0-0-178"
                    git config --global user.name "JenkinsSeloTapeTM"
                    git checkout releases
                    git merge origin/main
                    sed -i "s|image: .*|image: ${PROD_IMAGE_URL}|g" ${YAML_FILE}
                    git add $YAML_FILE
                    git commit -m "$PROD_IMAGE_URL"
                    git push https://SeloTapeTM:$PASS@github.com/SeloTapeTM/cicd-poly-project.git releases
                    '''
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}