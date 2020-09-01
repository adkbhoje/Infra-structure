pipeline {
	agent any
  stages {
  
    stage('checkout') {
        steps {
            script {
                echo "TARGET_ENVIRONMENT: ${params.TARGET_ENVIRONMENT}"
                if("${params.TARGET_ENVIRONMENT}" == "INT") {
                    echo 'checkout the code from the develop'
                } else {
                    echo 'checkout the code from master'
                }
            }
        }
    }
   }
	}
