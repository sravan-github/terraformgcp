pipeline {
  //agent any
  agent {
  docker { 
            image 'sravangcpdocker/terraform:7'
            args '-u root:root'
        }
        }
        /*
  environment {
   ANSIBLE_PRIVATE_KEY=credentials('ansible-key') 
  }*/
  stages {
    stage('Hello') {
      steps {
        sh '''
            git clone https://github.com/sravan-github/terraformgcp.git
            ls -l
            pwd
            terraform init
            terraform plan            
            '''
      }
    }
  }
  post {
        always {
        	cleanWs deleteDirs: true
        }
    }
}
