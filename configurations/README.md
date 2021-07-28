# API Gateway Configurations via Ansible

Implemented configuration items

Here are the current configuration items implemented by this project:
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
 - import apigateway archive (from s3)
 - set api plans
 - set api packages
 - set aliases
 - set api applications
 - set apiportal destination
 - publish apis to apiportal
 - publish api packages to apiportal

# Pre-requisite

## A working and accessible API Gateway / API Portal

To test the configurations playbook, you'll need a working and network accessible apigateway (and optionally an apiportal if you want to test the gateway to portal publishing)
The versions tested are 10.5 and 10.7. 
## SSL configurations

If you already have certs to test with, simply update the env file with the required values (for example, env vars in section "ssl certs" in ./envs/envs_sample1)

But if not, let's generate some self-sign certs for testing:

1) Create a private key and public certificate

```bash
openssl req -newkey rsa:2048 -x509 -keyout sagdemokey.pem -out sagdemocert.pem -days 3650
```

2) Create a PKCS12 keystore

```bash
openssl pkcs12 -export -in sagdemocert.pem -inkey sagdemokey.pem -out sagdemokey.p12 -name "sagdemo"
```

3) Convert the PKCS12 keystore to JKS keytstore using keytool command

```bash
keytool -importkeystore -destkeystore sagdemokey.jks -deststoretype pkcs12 -srckeystore sagdemokey.p12 -srcstoretype PKCS12
```

4) Create a trust store

```bash
keytool -import -file sagdemocert.pem -alias sagdemocert -keystore sagdemotrust.jks
```

In the end, you should have the following 2 files (in addition to 3 other intermediary files) which we'll use for the gateway configs:
 - sagdemokey.jks
 - sagdemotrust.jks


IMPORTANT: please be sure to update the env vars related to these new generated files (ie. the env vars in section "ssl certs" in ./envs/envs_sample1)

```
env_apigateway_keystore_filepath="sagdemokey.jks"
env_apigateway_truststore_filepath="sagdemotrust.jks"
```

# Running the playbook
## Load the right env variables in the shell

This project was built in such a way that the main config items can be provided by Environment Variables (to make it easy when it comes to containerizing the project down the road)
But the project could be updated easily to load the parameters from standard ansible var files should it be needed instead.

A sample env var file is provided at [./envs/envs_sample1](./envs/envs_sample1).
From this example, create an ENV var file that works for you...and load all these ENVs in the shell where you'll be running ansible commands.

A simple shell command provided below will do just that (take all the params in the file, and export them as ENV vars in your shell):

```bash
ENV_VAR_FILE=./envs/envs_sample1
source <( sed -E -n 's/[^#]+/export &/ p' $ENV_VAR_FILE )
```
## Run the playbook

Once the ENVs vars are loaded in the shell, the Ansible playbook should have everything it needs to execute...

Simply run:

```bash
ansible-playbook apply_configs.yaml
```
# Env variables Details

## Enable / Disable Flags

| Env Var                                          | Values Type | Description                                                                  | Default value |
|--------------------------------------------------|-------------|------------------------------------------------------------------------------|---------------|
| env_apigateway_configure_usermgt                 | boolean     | Enable/disable creations of Users/Groups/Permissions                         | false         |
| env_apigateway_configure_aliases                 | boolean     | Enable/disable creation of aliases                                           | false         |
| env_apigateway_configure_keystoretruststore      | boolean     | Enable/disable uploading and config of keystores/trustores                   | false         |
| env_apigateway_configure_ports                   | boolean     | Enable/disable creations of gateway ports (internal, external,   websocket)  | false         |
| env_apigateway_configure_ldap                    | boolean     | Enable/disable creation of LDAP configs                                      | false         |
| env_apigateway_configure_saml                    | boolean     | Enable/disable creation of SAML configs                                      | false         |
| env_apigateway_configure_lb                      | boolean     | Enable/disable creation of ingress Load balancer urls                        | false         |
| env_apigateway_configure_promotions_stages       | boolean     | Enable/disable creation of promotion stages                                  | false         |
| env_apigateway_configure_extended_settings       | boolean     | Enable/disable creation of gateway extended settings                         | false         |
| env_apigateway_configure_plans                   | boolean     | Enable/disable creation of API plans                                         | false         |
| env_apigateway_configure_packages                | boolean     | Enable/disable creation of API packages                                      | false         |
| env_apigateway_configure_applications            | boolean     | Enable/disable creation of API applications (with mapping to apis)           | false         |
| env_apigateway_configure_archives                | boolean     | Enable/disable import of APIGateway archives                                 | false         |
| env_apigateway_configure_portalgateway           | boolean     | Enable/disable config of API Portal destination                              | false         |
| env_apigateway_configure_apis_publish_groups     | boolean     | Enable/disable publshing of APIs to API Portal                               | false         |
| env_apigateway_configure_packages_publish_groups | boolean     | Enable/disable publshing of API PAckages to API Portal                       | false         |

## Others



______________________
These tools are provided as-is and without warranty or support. They do not constitute part of the Software AG product suite. Users are free to use, fork and modify them, subject to the license agreement. While Software AG welcomes contributions, we cannot guarantee to include every contribution in the master project.
_____________
For more information you can Ask a Question in the [TECHcommunity Forums](http://tech.forums.softwareag.com/techjforum/forums/list.page?product=webmethods).

You can find additional information in the [Software AG TECHcommunity](http://techcommunity.softwareag.com/home/-/product/name/webmethods).
_____________
Contact us at [TECHcommunity](mailto:technologycommunity@softwareag.com?subject=Github/SoftwareAG) if you have any questions.
