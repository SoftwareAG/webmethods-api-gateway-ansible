# Configurations

## Adding local to ansible

Because we run this from the local ansible server, we need to add the "local" config to set that up:

```bash
echo "[local]" >> /etc/ansible/hosts
echo "localhost ansible_connection=local" >> /etc/ansible/hosts
```

## Load the env var file in the runner

```bash
source <(sed -E -n 's/[^#]+/export &/ p' envs/envs_sample)
```