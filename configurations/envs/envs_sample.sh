
# the env stage (ie. dev, test, staging, prod)
env_apigateway_stage="dev"

# the flags to enable/disable the config item
env_apigateway_configure_usermgt="true"
env_apigateway_configure_portalgateway="true"
env_apigateway_configure_archives="true"
env_apigateway_configure_aliases="true"
env_apigateway_configure_ports="true"
env_apigateway_configure_ldap="true"
env_apigateway_configure_saml="true"
env_apigateway_configure_lb="true"
env_apigateway_configure_promotions_stages="true"
env_apigateway_configure_extended_settings="true"
env_apigateway_configure_plans="true"
env_apigateway_configure_packages="true"
env_apigateway_configure_applications="true"
env_apigateway_configure_apis_publish_groups="true"
env_apigateway_configure_packages_publish_groups="true"

# apigateway target
env_apigateway_protocol="http"
env_apigateway_host="dev"
env_apigateway_port="5555"

## rest login info
env_apigateway_rest_user="Administrator"
env_apigateway_rest_password="somethingnew"
env_apigateway_rest_password_old="manage"

## aws s3 repo artifacts
env_apigateway_aws_s3_bucket=""
env_apigateway_aws_s3_bucket_prefix=""

## local sample users
env_apigateway_users_sample1_username="sampleuser1.apiadmin"
env_apigateway_users_sample1_password="changeme"
env_apigateway_users_sample2_username="sampleuser2.apiprovider"
env_apigateway_users_sample2_password="changeme"
env_apigateway_users_sample3_username="sampleuser3.apiuser"
env_apigateway_users_sample3_password="changeme"

## apigateway load balancer envs
env_apigateway_lb_http_url="http://external_api_access"
env_apigateway_lb_https_url="https://external_api_access"
env_apigateway_lb_websocket_url=""
env_apigateway_lb_webapp_url="https://external_webapp"

## api gateway portal registration
env_apigateway_portalgateway_version="1.0"
env_apigateway_portalgateway_gateway_username="Administrator"
env_apigateway_portalgateway_gateway_password="somethingnew"
env_apigateway_portalgateway_gateway_url="http://internal_apigateway:5555"
env_apigateway_portalgateway_portal_url="http://internal_apiportal:18101"
env_apigateway_portalgateway_portal_username="system"
env_apigateway_portalgateway_portal_password="something"

## api endpoint aliases
env_apigateway_aliases_bookstore_endpoint="http://internal_bookstore:5555"
env_apigateway_aliases_uszip_endpoint="http://internal_uszip:5555"