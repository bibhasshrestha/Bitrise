pipeline {
     agent {
        docker { image 'ubuntu:latest' }
    }
    stages {
       stage('Checkout to the testing Repo') {
            steps {
               checkout scm
            }
        }
        stage('Run qualii script') {
            steps { 
                sh "chmod +x ./qualiti-script.sh"
                bash "./qualiti-script.sh"   
            }
        }
    }
}
