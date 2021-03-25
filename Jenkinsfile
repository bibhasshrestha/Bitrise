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
                sh "pwd"
                sh "ls"
                sh "chmod +x ./qualiti-script.sh"
                sh "./qualiti-script.sh"   
            }
        }
    }
}
