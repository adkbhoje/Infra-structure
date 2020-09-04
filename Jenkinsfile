pipeline {
	environment {
		customImage = ''
	}
	agent {
		dockerfile {
			filename 'Dockerfile'
			reuseNode false
		}
	}
  
	stages {
		stage('Build image') {
			steps {
			    withCredentials([[
				    $class: 'AmazonWebServicesCredentialsBinding',
				    credentialsId: 'sus-aws-cred',
				    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
				    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
			    ]]) {
					sh 'packer build -debug -var aws_access_key=${AWS_ACCESS_KEY_ID} -var aws_secret_key=${AWS_SECRET_ACCESS_KEY} ./packer/packer.json'
				        sh 'packer validate -var aws_access_key=${AWS_ACCESS_KEY_ID} -var aws_secret_key=${AWS_SECRET_ACCESS_KEY} ./packer/packer.json'

				    }
			
		    }
		}
		stage('Deploy Infrastructure') {
			steps { 
				withCredentials([[
				    $class: 'AmazonWebServicesCredentialsBinding',
				    credentialsId: 'sus-aws-cred',
				    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
				    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
			    ]]) {
				           
				        //sh 'echo `pwd`'
					sh 'terraform init -var accessKey=${AWS_ACCESS_KEY_ID} -var secretKey=${AWS_SECRET_ACCESS_KEY}'	
				        sh 'terraform plan -var accessKey=${AWS_ACCESS_KEY_ID} -var secretKey=${AWS_SECRET_ACCESS_KEY}'
					sh 'terraform apply -auto-approve -var accessKey=${AWS_ACCESS_KEY_ID} -var secretKey=${AWS_SECRET_ACCESS_KEY}'
					//sh 'terraform destroy -auto-approve -var accessKey=${AWS_ACCESS_KEY_ID} -var secretKey=${AWS_SECRET_ACCESS_KEY}'
				    }
			}
		}
	}
}
