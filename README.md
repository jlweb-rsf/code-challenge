##### Overview

 - The files in the [TASK](./TASK1) directory are all playbooks, codes and scripts to bootstrap an Apache server and load balancer on AWS. 🚀
 - I wrote a short description on each terraform file to declare what is the purpose of each of them.
 - Technologies used in this practice:
    * Terraform (To provision AWS infrastructure).
    * Ansible (To deploy apache web server).
    * Github Action as CICD tool.
    * Docker and Docker-compose to run a simple Golang monitoring application.


##### CI/CD clarifications:

- I have set CI/CD pipeline workflows [Github Action](./.github/workflows) for provisioning the infrastructure, CI pipeline (linting and testing), and also for destroying.

- You can easily clone the repository and use it in your desired configurations. You just need to define AWS access keys on repository secrets.

- The deployment [workflow](./.github/workflows/provision.yml) run by pushing the code into or merging with branch `main` and perform the following actions:
    * provision infrastructures described on terraform configuration files.
    * a delayed job is triggered to wait for few minutes till EC2 instances being ready.
    * Finally, the ansible-playbook will be run to deploy a simple Apache web server on the target instance. The content will be the default Apache web server and it shows a simple HTML page (aka APACHE TEST PAGE) by pointing ALB_DNS_RECORD:8080 in your browser.

- The CI [workflow](./.github/workflows/check.yml) (which is run on branch `dev`) contains a linting process to check the typo and code style on Ansible roles and also testing the whole playbook on different Linux distributions with molecule.

- I have set a [workflow](./.github/workflows/destroy.yml) in order to destroy the created resources which would be run mannually.

##### Checking The Apache Service periodically

 1- There is a [workflow](./.github/workflows/check.yml) to check the Apache service is up and running. It uses a simple ansible ad-hoc command to SSH to the server and ensure httpd service is running as expected. The same command could be triggered from outside by providing the Inventory and Key file.

 2- Direcotry [monitor](./TASK1/monitor/) contains a simple application written in Go to check the server availability and notify based on its [configurations](./TASK1/monitor/configs/default.json). You Just need to update the IP address and Slack tokens in config file and simply build the Dockerfile by running `docker-compose build` and `docker-compose up`.

 3- There's also a shell [script](./task1/../TASK1/http-status/status.sh) to chech the http status code with a simple usage. Just run this command and replace the URL: `status.sh $YOUR_URL`