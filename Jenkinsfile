pipeline {
    agent any
    environment {
        BUILD = "${env.BUILD_ID}"
    }
    parameters {
        choice(name: 'repository_branch', choices: ['master', 'jenkins'], description: 'Pick the branch')
        string(name: 'repository_url', defaultValue: 'https://github.com/Den4ik27/drupal_project', description: 'Github repository url')
        booleanParam(name: 'do_clean', defaultValue: true, description: 'Do we need clean old one package?')
    }
    stages {
        stage('Clone repository') {
            steps {
                    git branch: "${params.repository_branch}", url: "${params.repository_url}"

            }
        }
        stage('Checking repository'){
            steps { 
                    sh "ls -l"
            }
        }
        stage('Docer compose check file') {
            steps {
                sh '''
                    docker-compose config
                '''
            }
        }
        stage('Docer UP') {
            steps {
                sh '''
                    docker-compose up -d
                '''
            }
        }
        stage('Packing test') {
            steps {
                sh "ls -l"
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