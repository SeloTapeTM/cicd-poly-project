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
                python -c "import sys;lines=sys.stdin.read();print lines.replace('image: IMG_NAME','image: $POLYBOT_PROD_IMAGE_URL')" < k8s/prod/polybot.yaml
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