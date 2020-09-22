pipeline {
    agent {
        node { label 'master' }
    }
    parameters {
        string(name: 'NAMESPACE', defaultValue: 'automation', description: 'K8 namespace')
        string(name: 'KUBECONFIG', defaultValue: '/home/samarth/.kube/config', description: 'kubeconfig path on master node')
        string(name: 'adminConsoleIP', defaultValue: 'localhost', description: 'adminConsoleIP')
        string(name: 'adminName', defaultValue: 'admin', description: 'adminName')
        string(name: 'adminPassword', defaultValue: 'novell', description: 'adminPassword')
        string(name: 'acNode', defaultValue: 'novell-virtual-machine', description: 'am-ac.Node')
        string(name: 'imageRepo', defaultValue: 'security-accessmanager-docker.btpartifactory.swinfra.net/beta', description: 'docker image repo location')
        string(name: 'helmRepoName', defaultValue: 'access-manager-beta-charts', description: 'helm repo name')
        string(name: 'helmRepo', defaultValue: 'https://btpartifactory.swinfra.net/artifactory/security-accessmanager-helm-release/', description: 'helm repo location')
        string(name: 'chartVersion', defaultValue: '1.0.0', description: 'helm chart version')
        }
    stages {
        stage('clean worksapce') {
            steps {
                sh 'echo "clean" '
                cleanWs()
                    }
            }
        stage('clone repo') {
            steps {
                sh 'echo "clone" '
                git branch: 'master',
                credentialsId: 'githubapi',
                url: 'https://github.com/richapandey0009/NAM-Docker-Deployment.git'
                }
            }
        stage('Existing Setup Cleanup') {
            steps {
                sh "echo 'Setup Cleanup' "
                
                //remove K8 resources from the namespace
                sh "ansible-playbook ${WORKSPACE}/yml_scripts/cleanupNAM.yml -e 'namespace=${params.NAMESPACE} kubeconfig=${params.KUBECONFIG}' "
                
                //remove persistent directories from all nodes
                sh "ansible-playbook ${WORKSPACE}/yml_scripts/removePersistentDirectories.yml"
                
                //remove docker images from all nodes
                sh "ansible-playbook ${WORKSPACE}/yml_scripts/removeDockerImages.yml"
                }
            }
        stage('Deploy NAM Docker setup') {
            steps {
                sh "echo 'NAM Docker deployment' "
                
                //deploy using helm charts
                sh "ansible-playbook ${WORKSPACE}/yml_scripts/installNAM.yml -e 'namespace=${params.NAMESPACE} adminConsoleIP=${params.adminConsoleIP} acNode=${params.acNode} imageRepo=${params.imageRepo} helmRepoName=${params.helmRepoName} helmRepo=${params.helmRepo} chartVersion=${params.chartVersion} kubeconfig=${params.KUBECONFIG}' "
                }
            }
        stage('Pod Readiness check') {
            steps {
                script {
                    try {
                            sh "echo 'Pod Readiness check' "
                
                            sleep(time:360,unit:"SECONDS")
                
                            //wait untill all Pods are in Ready state
                            sh "ansible-playbook ${WORKSPACE}/yml_scripts/waitForPodsReadyState.yml -e 'namespace=${params.NAMESPACE}' "
                        } catch (e) {
                            echo e.toString()
                        }
                }
            }
        }
        stage('Run smoke test cases') {
            steps {
                sh "echo 'Run smoke test cases' "
                sh "ansible-playbook ${WORKSPACE}/yml_scripts/checkServices.yml -e 'namespace=${params.NAMESPACE}' "
                }
            }
        stage('Run selenium test cases') {
            steps {
                sh "echo 'Running selenium test cases' "
               // build job: 'Docker-Selenium-2-Sanity-run', 
				//parameters: [string(name: 'AC', value: "ubuntu-machine"),string(name: 'AC_IP', value: "164.99.91.118"),string(name: 'IDP1', value: "novell-virtual-machine)",string(name: 'IDP1_IP', value: "164.99.91.119"),string(name: 'AG1', value:"www.dockerAG.com"),string(name: 'AG1_IP', value:"164.99.91.119"),string(name: 'MODULE', value:"nam-jenkins-fresh-install-config.xml"),string(name: 'SELENIUM_HUB_IP', value:"164.99.185.187")]
                }
            }
    }
}
