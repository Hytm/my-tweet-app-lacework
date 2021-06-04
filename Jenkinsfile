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
                LW_API_SECRET = credentials('lacework_api_secret')
            }
            agent {
                docker { image 'securethecloud/lw-scanner:latest' 
                         args '-v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker'
                       }
            }
             
            when {
                branch 'master'
            }
            steps {
                echo 'Running Lacework vulnerability scan'
                sh "lw-scanner evaluate $image $tag -l /tmp/lw-scanner/logs -d /tmp/lw-scanner/data"
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
