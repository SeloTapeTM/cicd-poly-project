pipeline {
    agent any
    options {
        timestamps()
    }
    parameters { string(name: 'POLYBOT_PROD_IMAGE_URL', defaultValue: '', description: '') }

    stages {
        stage('Update YAML') {
            steps {
                sh '''
                git checkout releases
                git merge origin/main
                sed -i 's/image: .*/image: $POLYBOT_PROD_IMAGE_URL/g' k8s/prod/polybot.yaml
                cat k8s/prod/polybot.yaml

                git add k8s/prod/polybot.yaml
                git commit -m "$POLYBOT_PROD_IMAGE_URL"
                git push origin releases
                '''
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}