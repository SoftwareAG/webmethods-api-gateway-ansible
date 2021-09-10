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

If you already have certs to test with, simply update the [dev env file](./environments/dev/apigateway.yaml) with the required values (under section "ssl certs")

BUT, if not, we've generated 2 sample self-signed certs + truststore for you:
 - ./demo_artifacts/sagdemocerts.jks
 - ./demo_artifacts/sagdemotrust.jks

All relevant cert details are already added to the sample configuration at [./environments/dev/apigateway.yaml](./environments/dev/apigateway.yaml)

# Running the sample playbook

## Update the env variable files

The general values to update are in the ./environments folder. We have provided 2 sample environment files to demonstrate how you can change env values from environment to environment:
- [local env file](./environments/local/apigateway.yaml) - for running the playbook directly on your local environment (or directly on a server that has ansible, apigateway, apiportal altogether)
- [dev env file](./environments/dev/apigateway.yaml) - for running the playbook against your "fictitious" DEV environment
- [prod env file](./environments/prod/apigateway.yaml) - for running the playbook against your "fictitious" PROD environment

In these env files, most values are correct for the demo, but a few will need to be changed based on your environment...such as:

- Connectivity info to the API GATEWAY server (needed to run the configurations against your target apigateway)
  - envvars_apigateway_protocol: "http"
  - envvars_apigateway_host: "<YOUR API GATEWAY SERVER IP/HOSTNAME>"
  - envvars_apigateway_port: "<YOUR API GATEWAY SERVER PORT, usually 5555>"

- Connectivity credentials to the API GATEWAY server (to be able to connect to the internal APIs, as well as change the default password to something else -- ie. the value in envvars_apigateway_rest_login_password will be the new password...)
  - envvars_apigateway_rest_login_username: "Administrator"
  - envvars_apigateway_rest_login_password: "<A new password to apply for user Administrator>"
  - envvars_apigateway_rest_login_password_old: "<The default api gateway password for user Administrator>"

- Connectivity info to the API PORTAL server (ONLY needed to test the publishing from APIGateway to API Portal, NOT to configure API Portal in this case)
  - envvars_apiportal_protocol: "http"
  - envvars_apiportal_host: "<YOUR API PORTAL SERVER IP/HOSTNAME>"
  - envvars_apiportal_port: "<YOUR API PORTAL SERVER PORT, usually 18101>"

- Connectivity credentials to the API PORTAL server (ONLY needed to test the publishing from APIGateway to API Portal)
  - envvars_apigateway_portalgateway_portal_username: "system"
  - envvars_apigateway_portalgateway_portal_password: "<The api portal password for user system>"

- External load balancer urls
  - envvars_apigateway_loadbalancers_http_urls: "<YOUR EXTERNAL NON-SSL LOADBALANCER ACCESS FOR GATEWAY HTTP RUNTIME ENDPOINT>"
  - envvars_apigateway_loadbalancers_https_urls: "<YOUR EXTERNAL SSL LOADBALANCER ACCESS FOR GATEWAY HTTPS RUNTIME ENDPOINT>"
  - envvars_apigateway_loadbalancers_websocket_urls: "ws://<YOUR EXTERNAL LOADBALANCER ACCESS FOR GATEWAY WEBSOCKET RUNTIME ENDPOINT>"
  - envvars_apigateway_loadbalancers_webapp_url: "<YOUR EXTERNAL LOADBALANCER ACCESS FOR GATEWAY UI ENDPOINT>"

Some other values like the sample user passwords, or the keystores/trustures could also be updated as desired...

Update all these values in the env file you'll be using for your first run...

## Run the playbook

Once the ENVs vars are updated correctly, the Ansible playbook should have everything it needs to execute...

Simply run for a DEV deployment:

```bash
ansible-playbook apply_configs.yaml --extra-vars '{ env : dev }'
```

Simply run for a PROD deployment:

```bash
ansible-playbook apply_configs.yaml --extra-vars '{ env : prod }'
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


# Appendix: Self-signed SSL certificates generation 

To generate some self-sign certs for testing:

1) Create a private key and public certificate

```bash
openssl req -newkey rsa:2048 -x509 -keyout ./demo_artifacts/sagdemokey.pem -out ./demo_artifacts/sagdemocert.pem -days 3650
```

2) Create a PKCS12 keystore

```bash
openssl pkcs12 -export -in ./demo_artifacts/sagdemocert.pem -inkey ./demo_artifacts/sagdemokey.pem -out ./demo_artifacts/sagdemocerts.p12 -name "sagdemo"
```

demo123!

3) Convert the PKCS12 keystore to JKS keytstore using keytool command

```bash
keytool -importkeystore -destkeystore ./demo_artifacts/sagdemocerts.jks -deststoretype pkcs12 -srckeystore ./demo_artifacts/sagdemocerts.p12 -srcstoretype PKCS12
```

4) Create a trust store

```bash
keytool -import -file ./demo_artifacts/sagdemocert.pem -alias sagdemocert -keystore ./demo_artifacts/sagdemotrust.jks
```

In the end, you should have the following 2 files (in addition to 3 other intermediary files) which we'll use for the gateway configs:
 - sagdemocerts.jks
 - sagdemotrust.jks

IMPORTANT: please be sure to update the env vars related to these new generated files (ie. the env vars in section "ssl certs" in ./envs/envs_sample1)







______________________
These tools are provided as-is and without warranty or support. They do not constitute part of the Software AG product suite. Users are free to use, fork and modify them, subject to the license agreement. While Software AG welcomes contributions, we cannot guarantee to include every contribution in the master project.
_____________
For more information you can Ask a Question in the [TECHcommunity Forums](http://tech.forums.softwareag.com/techjforum/forums/list.page?product=webmethods).

You can find additional information in the [Software AG TECHcommunity](http://techcommunity.softwareag.com/home/-/product/name/webmethods).
_____________
Contact us at [TECHcommunity](mailto:technologycommunity@softwareag.com?subject=Github/SoftwareAG) if you have any questions.



