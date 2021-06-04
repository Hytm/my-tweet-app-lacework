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
            environment {
                LW_ACCOUNT_NAME = credentials('lw_account_name')
                LW_ACCESS_TOKEN = credentials('lw_access_token')
            }
            steps {
                sh 'echo "Hello World"'
                sh 'wget https://github.com/lacework/lacework-vulnerability-scanner/releases/download/v0.1.2/lw-scanner-linux-386'
                sh 'ls -la & pwd'
                sh 'mv ./lw-scanner-linux-386 ./lw-scanner'
                sh 'chmod +x ./lw-scanner'
                sh 'mkdir -p /tmp/lw-scanner/data'
                sh 'mkdir -p /tmp/lw-scanner/logs'
                sh './lw-scanner version'
                sh './lw-scanner evaluate $DOCKER_HUB/my-tweet-app-lacework latest -l /tmp/lw-scanner/logs -d /tmp/lw-scanner/data --debug'
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
