
properties([pipelineTriggers([githubPush()])])
node {

    agent { 
        node {
            label 'swarm-ci'//
        }
    }
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

    //security check to analysis any credential present in source code
         stage('Check-git-Secrets')
        { 
            steps {
            sh 're trufflehog||true'
            sh 'docker run gesellix/trufflehog --json https://github.com/ek2020/php-jenkins > trufflehog'
            sh 'cat  trufflehog'
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
