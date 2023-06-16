pipeline { 
    agent any
    stages {
        
        stage('Prerequisites') {
            steps {
                script {
                    sh 'pip install -r requirements.txt'
                }
            }
        }

        stage('GitHub Code') {
            steps {
                git branch: 'main', url: 'https://github.com/STRIKER013/PruebasAutomatizadasAppCenter.git'
            }
        }

        stage('SonarQube Test') {
            steps {
                withSonarQubeEnv('SonarQubeTest') {
                    script {
                        scannerHome = tool 'nombreToolDelScanner';
                        sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=<nombreProjectoSonar> -Dsonar.sources=. -Dsonar.host.url=http://<host> -Dsonar.login=sqp_<token>"
                    }
                }
            }
        }

        stage('API testing') {
            steps {
                script{
                    sh '/var/jenkins_home/.local/bin/pytest <reporte.txt>' //<nombre archivo de reporte>
                }
            }
        }

        stage('Report Finally') {
            steps {
                publishHTML(target: [
                    allowMissing: true,
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportDir: '.',
                    reportFiles: '<reporteFinal.txt>',
                    reportName: 'API Test Report'
                ])
            }
        }
    }
}
