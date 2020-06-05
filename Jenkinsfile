#!groovy
properties([pipelineTriggers([githubPush()])])
node {
    def app

    stages {
        /* checkout repo */
        stage('Checkout SCM') {
            steps {
                checkout([
                 $class: 'GitSCM',
                 branches: [[name: 'master']],
                 userRemoteConfigs: [[
                    url: 'https://github.com/ek2020/devops-training.git',
                    credentialsId: '',
                 ]]
                ])
            }
        }

    stage('Build image') {
        /* This builds the actual image */

        app = docker.build("karthick1998/angular")
    }


    stage('Push image') {
        /* 
			You would need to first register with DockerHub before you can push images to your account
		*/
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
            } 
                echo "Trying to Push Docker Build to DockerHub"
    }

    post {
       always {
           deleteDir()
       }
   }
}
}
    