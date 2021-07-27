# webmethods-api-gateway-ansible
A sample project that demonstrates how to use the Ansible roles to install and configure the API Gateway

# Authors
Fabien Sanglier
- Emails: [@Software AG](mailto:fabien.sanglier@softwareag.com) // [@Software AG Government Solutions](mailto:fabien.sanglier@softwareaggov.com)
- Github: 
  - [Fabien Sanglier](https://github.com/lanimall)
  - [Fabien Sanglier @ SoftwareAG Government Solutions](https://github.com/fabien-sanglier-saggs)

## Pre-requisite: Install Ansible

If not already done, you'll need to install Ansible onto a server of your choice. 
There are many tutorial expaining the task...so I will not re-iterate that here.

Few things to note:

 - Ansible does not have to be installed on the same server as webMethods ApiGateway. In fact, it usually should be its own "Ansible Management" server...(but not a strict requirement especially for testing)
 - The anisble server shoud have network connectivity to the runtime webMethods ApiGateway
   - SSH connectivity will be needed for installation, patching, and local file-base configurations
   - HTTP connectivity (on API Gateway runtime port) will be needed to call the REST APIs for the various configuration items
## Pre-requisite: Adding local to ansible

Because we run some tasks from the local ansible server, let's add the "local" config in the global ansible host:

```bash
echo "[local]" >> /etc/ansible/hosts
echo "localhost ansible_connection=local" >> /etc/ansible/hosts
```

## Pre-requisite: Install SoftwareAG ansible roles

This project uses the core ansible roles defined in [sagdevops-ansible-roles](https://github.com/SoftwareAG/sagdevops-ansible-roles)

You need to download the "sagdevops-ansible-roles" on the ansible server so it can be referenced by the playbook projects.

It is preferred to download a specific release for the "sagdevops-ansible-roles" to avoid incompatibilities.
Current supported /recommended version is [dev-0.2.3](https://github.com/SoftwareAG/sagdevops-ansible-roles/archive/refs/tags/dev-0.2.3.tar.gz)

## Pre-requisite: AWS S3 connectivity (optional)

Some of the playbooks are written in such a way to pull file artifacts from AWS S3. 
If you want to test such automation features, you will need to have an AWS S3 environment available from the Ansible server.

Such artifacts to pull from S3 are:
 - Installations artifacts:
   - SoftwareAG installer + SoftwareAG Update Manager (SUM) executables
   - Installer images + installer scripts
   - Fix images + sum scripts
 - Configurations artifacts
   - keystores, truststores
   - Apigateway archives to import


______________________
These tools are provided as-is and without warranty or support. They do not constitute part of the Software AG product suite. Users are free to use, fork and modify them, subject to the license agreement. While Software AG welcomes contributions, we cannot guarantee to include every contribution in the master project.
_____________
For more information you can Ask a Question in the [TECHcommunity Forums](http://tech.forums.softwareag.com/techjforum/forums/list.page?product=webmethods).

You can find additional information in the [Software AG TECHcommunity](http://techcommunity.softwareag.com/home/-/product/name/webmethods).
_____________
Contact us at [TECHcommunity](mailto:technologycommunity@softwareag.com?subject=Github/SoftwareAG) if you have any questions.
