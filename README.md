# my-tweet-app
Docker demo example application

![alt text](https://github.com/jeromebaude/my-tweet-app-lacework/blob/main/Pictures/picture.png?raw=true)

## For what is this repository?

This application was designed to show how easy it is to integrate Lacework Vulnerability Scanner with Visual Studio Code and GitHub Actions and fully auto manage the deployment of the application inside a AWS EKS Kubernetes cluster.

It is using a simple Docker container image based on Alpine, Python and Flask as componentes that have some critical and medium vulnerabilities.

## How can you use it?

To be able to use it you must have:

1. A Github account that you can use to fork this repository.
2. Installation of Visual Studio Code on your local machine (we only tested the integration with Visual Studio Code on macOS).
3. A AWS EKS Kubernetes cluster
4. Your AWS access key that is allowed to manage the EKS cluster.
5. A Lacework instance and an inline scanner token that can be used for the security scan.
6. A DockerHub account that can be used to save your images build via Github Actions.

### Create a Lacework Inline Scanner 

You need to create a Lacework Inline Scanner integration following [Create an Inline Scanner Integration in Lacework](https://support.lacework.com/hc/en-us/articles/1500001777821-Integrate-Inline-Scanner).

Make sure you also download the [lw-scanner binary](https://github.com/lacework/lacework-vulnerability-scanner/releases) to your local machine and configure it with Inline Scanner Integration in Lacework instructions.

### Get Visual Studio Code up and running.

To show the integration with Visual Studio Code we created a simple [tasks.json](.vscode/tasks.json) file you can use to show the integration of the Lacework Inline Scanner by using the Command Palette. You can trigger the different taks depending on your platform of your developer Laptop (x86 vs ARM). This integration was tested only on Mac OS! You can test it by executing a Task via Command+Shift+P and select one of the following:

* Lacework: Build, scan and delete Docker image for vulnerabilities (x86): Use this if your macOS is running on an Intel Processor, so it will auto build an intel x86 based docker image that will be used for scanning.
* Lacework: Build, scan and delete Docker image for vulnerabilities (ARM): Use this if your macOS is running on an M1 Processor, so it will auto build and intel x86 based docker image that will be used for scanning.

It is important to use the right Task, as you otherwise might see some diffs between your local image scan and the scan of the Github Actions.

### Create an AWS EKS cluster for your runtime.

Before you can use the full Github Actions deployment you need to create an AWS EKS cluster, so we can deploy the application to. We highly recommend using eksctl to create it [https://eksctl.io/](.https://eksctl.io/) Please make sure that you have the access key and secret of the account that was used to create the EKS cluster.

### DockerHub account

For the Github Action task to be able to push the image that will be used by your kubernetes cluster you need to have a DockerHub account that can be used for the repositories.

### Starting the Github Action tasks.

The Github Actions tasks defined inside [docker.yml](.github/workflows) will be auto started as soon as you commit anything to your new Github repository. However to get it up and running you need to configure the following secrets inside your Github repository (Settings > Secrets):

* LW_ACCOUNT_NAME: the name of your Lacework Account for example customer.fra
* LW_ACCESS_TOKEN: the access token created with the Lacework Inline Scanner integration.
* KUBE_CONFIG_DATA: KUBE_CONFIG_DATA – required: A base64-encoded kubeconfig file with credentials for Kubernetes to access the cluster. You can get it by running the following command:

cat $HOME/.kube/config | base64

* DOCKERHUB_USERNAME: Your Dockerhub Username
* DOCKERHUB_TOKEN: Your Dockerhub access token
* AWS_ACCESS_KEY_ID: Your AWS Access Key ID that is allowed to use the EKS cluster.
* AWS_SECRET_ACCESS_KEY: Your AWS Secret Access Key that is allowed to use the EKS cluster.


