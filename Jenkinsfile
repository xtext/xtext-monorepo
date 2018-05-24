node {
	properties([
		[$class: 'BuildDiscarderProperty', strategy: [$class: 'LogRotator', numToKeepStr: '15']]
	])
	
	stage('Checkout') {
		checkout scm
	}
	
	stage('Gradle Build') {
		sh "./gradlew clean cleanGenerateXtext build createLocalMavenRepo -PuseJenkinsSnapshots=true -PcompileXtend=true -PignoreTestFailures=true -PupstreamBranch=$BRANCH_NAME --refresh-dependencies --continue"
		step([$class: 'JUnitResultArchiver', testResults: '**/build/test-results/test/*.xml'])
	}
	
	stage('Gradle Longrunning Tests') {
		sh "./gradlew longrunningTest -PuseJenkinsSnapshots=true -PignoreTestFailures=true  -PupstreamBranch=$BRANCH_NAME --continue"
		step([$class: 'JUnitResultArchiver', testResults: '**/build/test-results/longrunningTest/*.xml'])
	}
	
	stage('Maven Build') {
		def mvnHome = tool 'M3'
		env.M2_HOME = "${mvnHome}"
		dir('.m2/repository/org/eclipse/xtext') { deleteDir() }
		sh "${mvnHome}/bin/mvn -f releng --batch-mode --update-snapshots  -DupstreamBranch=${BRANCH_NAME} -Dmaven.repo.local=.m2/repository -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn clean install"
	}
	
	archive 'build/**'
}
