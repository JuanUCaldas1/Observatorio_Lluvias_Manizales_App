pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Deploy DEV') {
            when { branch 'develop' }
            steps {
                sh 'chmod +x deploy.sh'
                sh './deploy.sh dev'
            }
        }

        stage('Deploy QA') {
            when { branch 'qa' }
            steps {
                sh 'chmod +x deploy.sh'
                sh './deploy.sh qa'
            }
        }

        stage('Deploy PDN') {
            when { branch 'main' }
            steps {
                input message: '¿Autorizar despliegue a PDN/producción?'
                sh 'chmod +x deploy.sh'
                sh './deploy.sh prod'
            }
        }
    }
}
