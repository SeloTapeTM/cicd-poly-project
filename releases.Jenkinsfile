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
                python -c "import sys;lines=sys.stdin.read();print lines.replace('blue','azure')" < input.txt

                git checkout releases
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