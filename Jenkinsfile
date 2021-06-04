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
        stage('Lacework Vulnerability Scan with lw-scanner') {
            steps {
                sh 'echo "Hello World"'
                sh 'wget https://github.com/lacework/lacework-vulnerability-scanner/releases/download/v0.1.2/lw-scanner-linux-386'
                sh 'chmod +x ./lw-scanner'
                sh './lw-scanner version'
                sh '''
                    echo "Multiline shell steps works too"
                    ls -lah
                '''
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
    }
}
