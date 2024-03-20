pipeline {
    agent any
    options {
        timestamps()
    }
    parameters { string(name: 'POLYBOT_PROD_IMAGE_URL', defaultValue: '', description: '') }

    stages {
        stage('Update YAML') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'github-token', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''

                    git config --global user.email "Jenkins@ip-10-0-0-178"
                    git config --global user.name "JenkinsSeloTapeTM"
                    git checkout releases
                    git merge origin/main
                    sed -i "s|image: .*|image: ${POLYBOT_PROD_IMAGE_URL}|g" k8s/prod/polybot.yaml
                    echo "test"
                    cat k8s/prod/polybot.yaml
                    echo "test"
                    git add k8s/prod/polybot.yaml
                    git commit -m "$POLYBOT_PROD_IMAGE_URL"
                    git push https://github.com/SeloTapeTM/cicd-poly-project.git releases
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