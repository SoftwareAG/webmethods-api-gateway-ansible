# webmethods-api-gateway-ansible

A project that demonstrates how to use of [Ansible](https://github.com/ansible/ansible) to install and configure the API Gateway.

This project makes use of common Ansible roles available at [sagdevops-ansible-roles](https://github.com/SoftwareAG/sagdevops-ansible-roles) 

# Authors

Fabien Sanglier
- Emails: [@Software AG](mailto:fabien.sanglier@softwareag.com) // [@Software AG Government Solutions](mailto:fabien.sanglier@softwareaggov.com)
- Github: 
  - [Fabien Sanglier](https://github.com/lanimall)
  - [Fabien Sanglier @ SoftwareAG Government Solutions](https://github.com/fabien-sanglier-saggs)

# Content

After you go through the general pre-requisites detailed on this page, simply refer to the following sub-sections based on what you want to do:

- [API Gateway Configuration via Ansible](./configurations/README.md)
  - Here are the current configuration items implemented by this project:
    - update admin password
    - set ports
    - set ssl certs (keystore, truststore)
    - set extended settings
    - set ldap
    - set loadbalancer urls
    - set promotion stages
    - create users
    - create groups and assign the users
    - create teams and assign the groups
    - import apigateway archive
    - set api plans
    - set api packages
    - set aliases
    - set api applications
    - set apiportal destination
    - publish apis to apiportal
    - publish api packages to apiportal
- [API Gateway Installation via Ansible](./installations/README.md)
  - Here are the current installation items implemented by this project (to-add)
    - Installation of Gateway nodes
    - Patching of gateway nodes
    - Local configs (ie. JVM tuning, etc...)
    - Clustering and Connectivity to external Elastic Search

# Pre-requisites

## Install Ansible

If not already done, you'll need to install Ansible onto a server of your choice. 
There are many tutorial expaining the task...so I will not re-iterate that here.

Few things to note:

 - Ansible does not have to be installed on the same server as webMethods ApiGateway. In fact, it usually should be its own "Ansible Management" server...(but not a strict requirement especially for testing)
 - The anisble server shoud have network connectivity to the runtime webMethods ApiGateway
   - SSH connectivity will be needed for installation, patching, and local file-base configurations
   - HTTP connectivity (on API Gateway runtime port) will be needed to call the REST APIs for the various configuration items
## Adding local to ansible

Because we run some tasks from the local ansible server, let's add the "local" config in the global ansible host:

```bash
echo "[local]" >> /etc/ansible/hosts
echo "localhost ansible_connection=local" >> /etc/ansible/hosts
```

## Download the ansible roles

This project uses the core ansible roles defined in [sagdevops-ansible-roles](https://github.com/SoftwareAG/sagdevops-ansible-roles)

You need to download and extract the "sagdevops-ansible-roles" on the ansible server so it can be referenced by this playbook projects.

Make sure to update the value "roles_path" in "ansible.cfg" to include the path to the newly downloaded/extracted roles (see [./configurations/ansible.cfg](./configurations/ansible.cfg) for working example)

It is preferred to download a specific release for the "sagdevops-ansible-roles" to avoid incompatibilities.

Current supported /recommended version is [dev-0.2.3](https://github.com/SoftwareAG/sagdevops-ansible-roles/archive/refs/tags/dev-0.2.3.tar.gz)

## AWS S3 connectivity (optional)

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
