pipeline {
    agent any
    stages {
        stage('Build Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    app = docker.build("$DOCKER_HUB/my-tweet-app-lacework")
                    app.inside {
                        sh 'cat /usr/src/app/app.py'
                    }
                }
            }
        }
        stage('Push Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        stage('Lacework Vulnerability Scan') {
            environment {
                LW_API_SECRET = credentials('lacework_api_secret')
            }
            agent {
                docker { image 'techallylw/lacework-cli:latest' }
            }
            when {
                branch 'master'
            }
            steps {
                echo 'Running Lacework vulnerability scan'
                sh "lacework vulnerability container scan index.docker.io $DOCKER_HUB/my-tweet-app-lacework latest --poll --noninteractive --details"
            }
        }
    }
}
