node {
  stage('Github') {
    checkout scm
  }
  stage('Create virtual env'){
    sh '''IMAGE_NAME="test-image"
          echo "Check current working directory"
          pwd
          echo "Build docker image and run container"
          docker build -t $IMAGE_NAME -f Dockerfile.test .
          docker run -d --name test-container -e DB_HOST=mongodb+srv://jhonatan:D8JNwKf1bsO2kJtL@estudio.evopu.mongodb.net/tests $IMAGE_NAME'''
  }
  stage('SonarQube Analysis') {
    def scannerHome = tool 'SonarScanner';
    withSonarQubeEnv() {
      sh "${scannerHome}/bin/sonar-scanner"
    }
  }
  stage('API Testing'){
    sh '''CONTAINER_NAME="test-container"
          rm -rf reports; mkdir reports
          docker stop $CONTAINER_NAME
          docker cp $CONTAINER_NAME:/code/result.txt reports/'''
  }
  stage('Clear'){
    sh '''docker rm test-container
          docker rmi test-image'''
    // cleanWs()
  }
}