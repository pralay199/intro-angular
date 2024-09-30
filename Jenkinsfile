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
        DEPLOY_USER = 'root'
        DEPLOY_SERVER = '37.60.254.21'
        SSH_CREDENTIALS_ID ='ssh_key_server_2'

    }

    stages {
        // stage('Build') {
        //     steps {
        //         script {
                    
        //             withCredentials([usernamePassword(credentialsId: "${env.DOCKER_CREDENTIALS_ID}", passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKERHUB_NAME')]) {
        //                 sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKERHUB_NAME --password-stdin'
        //             }

        //             sh "docker build -t ${env.DOCKERHUB_NAME}/${env.DOCKER_IMAGE}:${env.IMAGE_VERSION} ."
        //             sh "docker push ${env.DOCKERHUB_NAME}/${env.DOCKER_IMAGE}:${env.IMAGE_VERSION}"
        //             sh 'docker logout'
        //         }
        //     }
        // }

        

        stage('Deploy to Remote Server') {
            steps {
                script {
                    sshagent([env.SSH_CREDENTIALS_ID]) {
                        // SSH into the remote server, pull the Docker image, and run it
                        sh """
                            ssh ${env.DEPLOY_USER}@${env.DEPLOY_SERVER} << EOF
                                docker login -u ${env.DOCKERHUB_NAME} -p ${env.DOCKER_PASSWORD}
                                docker pull ${env.DOCKERHUB_NAME}/${env.DOCKER_IMAGE}:${env.IMAGE_VERSION}
                                docker stop ${env.DOCKER_IMAGE} || true
                                docker rm ${env.DOCKER_IMAGE} || true
                                docker run -d --name ${env.DOCKER_IMAGE} ${env.DOCKERHUB_NAME}/${env.DOCKER_IMAGE}:${env.IMAGE_VERSION}
                                docker logout
                            EOF
                        """
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
