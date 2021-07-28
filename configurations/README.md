# Configurations

## Pre-requisite: API Gateway / API Portal

To test the configurations playbook, you'll need a working and network accessible apigateway (and optionally an apiportal if you want to test the gateway to portal publishing)
The versions tested are 10.5 and 10.7. 

## Implemented configuration items

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

## Load the env variables in the shell

Create some ENVs files with the right configuration values (TODO: detail the settings)
A sample env var file is at "./envs/envs_sample1 "

Then, load the vars in the shell with the following command (update the )

```bash
ENV_VAR_FILE=./envs/envs_sample1
source <( sed -E -n 's/[^#]+/export &/ p' $ENV_VAR_FILE )
```

## Run the playbook

```bash
ansible-playbook apply_configs.yaml
```

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

______________________
These tools are provided as-is and without warranty or support. They do not constitute part of the Software AG product suite. Users are free to use, fork and modify them, subject to the license agreement. While Software AG welcomes contributions, we cannot guarantee to include every contribution in the master project.
_____________
For more information you can Ask a Question in the [TECHcommunity Forums](http://tech.forums.softwareag.com/techjforum/forums/list.page?product=webmethods).

You can find additional information in the [Software AG TECHcommunity](http://techcommunity.softwareag.com/home/-/product/name/webmethods).
_____________
Contact us at [TECHcommunity](mailto:technologycommunity@softwareag.com?subject=Github/SoftwareAG) if you have any questions.
