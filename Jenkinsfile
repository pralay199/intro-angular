pipeline {
    agent { label 'my_server_1' }  // Specify the agent or node with the label 'my-label'

    parameters {
        string(name: 'version', defaultValue: 'v1', description: 'DOCKER IMAGE VERSION')  // String parameter
    }

    environment {
        DOCKER_IMAGE = 'intro'
        IMAGE_VERSION = "${params.version}"
        DOCKERHUB_NAME = 'pralay1993'
        DOCKER_CREDENTIALS_ID = 'pralay_doc_cred'
        DEPLOY_USER = 'root'
        DEPLOY_PATH = '~/deploy_path'
        DEPLOY_SERVER = '37.60.254.21'
        SSH_CREDENTIALS_ID ='ssh_key_server_2'
        COMPOSE_FILE_PATH = './docker-compose.yaml'        

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

        

        stage('Deploy to Remote Server with Docker Compose') {
            steps {
                script {
                    sshagent([env.SSH_CREDENTIALS_ID]) {
                        // Transfer Docker Compose file to remote server
                        sh """
                            scp ${env.COMPOSE_FILE_PATH} ${env.DEPLOY_USER}@${env.DEPLOY_SERVER}:${env.DEPLOY_PATH}/docker-compose.yml
                        """

                        // SSH into the remote server and deploy using Docker Compose
                        sh """
                            ssh ${env.DEPLOY_USER}@${env.DEPLOY_SERVER} << EOF
                                cd ${env.DEPLOY_PATH}
                                docker-compose pull  # Pull the latest image from Docker Hub
                                docker-compose up -d --remove-orphans  # Deploy using docker-compose
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
