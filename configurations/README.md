# Configurations

## Load the env variables in the shell

Create some ENVs files wigh the right configuration values. 
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


______________________
These tools are provided as-is and without warranty or support. They do not constitute part of the Software AG product suite. Users are free to use, fork and modify them, subject to the license agreement. While Software AG welcomes contributions, we cannot guarantee to include every contribution in the master project.
_____________
For more information you can Ask a Question in the [TECHcommunity Forums](http://tech.forums.softwareag.com/techjforum/forums/list.page?product=webmethods).

You can find additional information in the [Software AG TECHcommunity](http://techcommunity.softwareag.com/home/-/product/name/webmethods).
_____________
Contact us at [TECHcommunity](mailto:technologycommunity@softwareag.com?subject=Github/SoftwareAG) if you have any questions.
