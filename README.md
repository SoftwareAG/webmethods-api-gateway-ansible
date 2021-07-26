# webmethods-api-gateway-ansible
A sample project that demonstrates how to use the Ansible roles to install and configure the API Gateway


## Adding local to ansible

We need to add the "local" config

```bash
echo "[local]" >> /etc/ansible/hosts
echo "localhost ansible_connection=local" >> /etc/ansible/hosts
```