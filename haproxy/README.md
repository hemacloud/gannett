# haproxy Cookbook for centos 6.7
## Overview/Requirement

Create a chef cookbook to install HA-Proxy on a centos 6.7 server. Please use the chef bento vagrant image for your testing.

- Haproxy to be installed and running (version 1.5 or 1.6)
- It should Serve traffic on 80 externally
- Have a backend of www.google.com
- Have a health check to identify if the backend is up
- Pass Foodcritic and Rubocop Style testing (line length may be increased to 160)
- Include 100% Chefspec coverage of chef resources
- Have integration testing built in kitchen
- Support chef version 12.5.1 (chef-dk 0.11.2)
- Leverage custom resources or LWRP to manage the front and back ends
- project to be delivered on github and be able to run kitchen verify from any laptop using the environment outlined above to execute a successful creation and testing of the cookbook


### Prerequisites
* ChefDK setup
* Vagrant

#### Using the Test Kitchen
* Clone git repository to host machine.

Following command will be used

```

git clone https://github.com/hemacloud/gannett.git

cd haproxy

Run manual test

kitchen list (optional to see available instance)

kitchen create  default-bento-centos-67 (to create the Virtual instance)

kitchen  converge default-bento-centos-67 (to configure the instance)

kitchen verify default-bento-centos-67 (to perform test )

kitchen destroy default-bento-centos-67 (remove the instance )

single "kitchen test default-bento-centos-67" command will do all above listed four task create, converge, verify and destroy in one go  

```



### Platforms

CentOs 6.2

### Chef

- Chef 12.0 or later

### Cookbooks

haproxy

## Attributes

Right now this cookbook contains no attributes

## Recipe
### haproxy::default

TODO: this cookbook contains on only one default recipe.

e.g.
Just include `haproxy` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[haproxy]"
  ]
}
```

