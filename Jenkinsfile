pipeline {
    agent { label 'my_server_1' }  // Specify the agent or node with the label 'my-label'

    parameters {
        string(name: 'version', defaultValue: 'v1', description: 'DOCKER IMAGE VERSION')  // String parameter
    }

    environment {
        APP_ENV = 'production'  // Define environment variables
        DOCKER_IMAGE = 'intro'
        IMAGE_VERSION = "${params.version}"
        DEPLOY_PATH = '~/'
        DOCKERHUB_NAME = 'pralay1993'
        DOCKER_CREDENTIALS_ID = 'pralay_doc_cred'
    }

    stages {
        stage('Build') {
            steps {
                script {
                    
                    docker.withRegistry('https://index.docker.io/v1/', "${env.DOCKER_CREDENTIALS_ID}") {
                        sh "docker build -t ${env.DOCKERHUB_NAME}/${env.DOCKER_IMAGE}:${env.IMAGE_VERSION} ."
                        sh "docker push ${env.DOCKERHUB_NAME}/${env.DOCKER_IMAGE}:${env.IMAGE_VERSION}"
                    }
                }
            }
        }

        // stage('Test') {
        //     steps {
        //         echo "Running tests..."
        //         sh 'echo Testing...'
        //     }
        // }

        // stage('Deploy') {
        //     steps {
        //         echo "Deploying application to ${env.DEPLOY_PATH}..."
        //         sh "scp ${env.DOCKER_IMAGE} user@server:${env.DEPLOY_PATH}"  // Example deploy command
        //     }
        // }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
