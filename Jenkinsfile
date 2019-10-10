pipeline {
    agent any
    environment {
        BUILD = "${env.BUILD_ID}"
    }
    parameters {
        choice(name: 'repository_branch', choices: ['master', 'stage', 'QA'], description: 'Pick the branch')
        string(name: 'repository_url', defaultValue: 'https://github.com/Den4ik27/drupal_project', description: 'Github repository url')
        booleanParam(name: 'Install_Portainer', defaultValue: true, description: 'Do you want to install Portainer?')
    }
    stages {
        stage('Clone repository') {
            steps {
                    git branch: "${params.repository_branch}", url: "${params.repository_url}"

            }
        }
        stage('Docker compose check file') {
            steps {
                sh '''
                    docker-compose config
                '''
            }
        }
        stage('Stop-rm Docker container for master') {
            when {
                expression {params.repository_branch == 'master'}
            }
            steps {
                sh './stop_master.sh'
            }
        }
        stage('Stop-rm Docker container for QA') {
            when {
                expression {params.repository_branch == 'QA'}
            }
            steps {
                sh './stop_QA.sh'
            }
        }    
        stage('Stop-rm Docker container for stage') { 
            when {
                expression {params.repository_branch == 'stage'}
            }
            steps {
                sh './stop_stage.sh'
            }
        }
        stage('UP with Docker-compose') {
            steps {
                sh '''
                    docker-compose up -d
                '''
            }
        }
        stage('Portainer ask installation') {
            when {
                expression {params.Install_Portainer == true}
            }
            steps {
                sh 'docker-compose -f portainer.yml up -d --force-recreate'
            }
        }
    }

    post {
            success {
                slackSend (color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
            }
            failure {
                slackSend (color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
            }
        }
}