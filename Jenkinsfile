pipeline {
     agent any
    stages {
       stage('Checkout to the testing Repo') {
            steps {
               checkout scm
            }
        }
        stage('Run qualii script') {
            steps { 
                sh "sudo chmod +x ./qualiti-script.sh"
                sh "sudo ./qualiti-script.sh"   
            }
        }
    }
}
