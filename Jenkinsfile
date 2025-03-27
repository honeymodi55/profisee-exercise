pipeline {
  agent any

  stages {
    stage('Terraform Plan') {
      steps {
        sh '''
            terraform init -upgrade
            terraform plan
        '''
      }
    }

    stage('Terraform Apply') {
      steps {
        input "Do you wanna apply terraform changes?"
        sh '''
            terraform apply -auto-approve
        '''
      }
    }
  }
}