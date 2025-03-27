pipeline {
  agent any

  stages {
    stage('Terraform Plan') {
      when {
        branch 'main'
      }
      steps {
        sh '''
            terraform init -upgrade
            terraform plan
        '''
      }
    }

    stage('Terraform Apply') {
      when {
        branch 'main'
      }
      steps {
        input "Do you wanna apply terraform changes?"
        sh '''
            terraform apply -auto-approve
        '''
      }
    }
  }
}