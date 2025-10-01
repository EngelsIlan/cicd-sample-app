node {
    stage('Preparation') {
        catchError(buildResult: 'SUCCESS') {
            sh 'docker stop samplerunning'
            sh 'docker rm samplerunning'
            sh 'ls'
        }
    }
    stage('Build') {
        build 'BuildSampleApp'
    }
    stage('Results') {
        build 'TestSampleApp'
    }
}   