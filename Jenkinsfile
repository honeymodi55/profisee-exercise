pipeline {
  agent any

  environment {
    AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
    AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
  }

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