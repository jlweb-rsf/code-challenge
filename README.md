##### Overview

 - The files in the [TASK1](./TASK1) directory are all playbooks, codes and scripts to bootstrap an Apache server and load balancer on AWS. 🚀


##### CI/CD clarifications:

- I have set CI/CD pipeline workflows [Github Action](./.github/workflows) for provisioning the infrastructure, CI pipeline (linting and testing), and also for destroying.

- You can easily clone the repository and use it in your desired configurations. You just need to define AWS access keys on repository secrets.

- The CD jobs run by pushing the code into the main branch in order to provision infrastructures described on terraform configuration files and then a delayed job is triggered to wait for few minutes till EC2 instances being ready.
Finally, the ansible-playbook will be run to deploy a simple Apache web server on the target instance.

- The CI job contains linting for Ansible roles and also testing the whole playbook on different Linux distributions with molecule.

- I have set a manual job in order to destroy the created resources.