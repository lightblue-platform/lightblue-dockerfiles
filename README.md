# About this repository

This repository is responsible to create the lightblue project deploy on any machine using Docker.

# Requirements

You will need to have [Docker](https://www.docker.com/) and [Terraform](https://www.terraform.io/intro/index.html) installed.

Why not [Docker Compose](http://docs.docker.com/compose/)? I wasn't able to get it to work on Fedora 22 and got fed up with it.

# Running using terraform

To install Terraform, just [download](https://www.terraform.io/downloads.html) and unpack it. No setup is needed.

Clone this repository. Assuming you have docker available via tcp://127.0.0.1:4243, run (where main.tf script is):
```
terraform apply
```

You can specify versions:
```
terraform apply -var 'lightblue_version=2.7.0'
```
By default, latest version is taken. See Docker Hub for a list of all available [lightblue versions](https://hub.docker.com/r/lightblue/lightblue/tags/). For 1.x versions you'll need to use 1.x branch of this repository.

Once started, you will have following services available:

* Data endpoint: http://localhost:8080/rest/data
* Metadata endpoint: http://localhost:8080/rest/metadata

## Running using bare docker
Here is how you can link lightblue containers togeather using docker:
```
docker run -d --name mongodb docker.io/mongo mongod --rest --httpinterface --smallfiles
docker run -d -p 8080:8080 -p 9999:9999 --name lightblue --link mongodb:mongodb docker.io/lightblue/lightblue /opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -Djboss.bind.address.management=0.0.0.0
```

See [dockerlinks](https://docs.docker.com/userguide/dockerlinks/) documentation for details. **WARNING**: Until fixed, [linking does not work on Fedora 22](https://forums.docker.com/t/docker-update-on-fedora-22-can-not-link-containers/2484)! Adjust firewall settings: ```sudo iptables -A DOCKER -p tcp -j ACCEPT```.

# License

The license of lightblue is [GPLv3](https://www.gnu.org/licenses/gpl.html).  See LICENSE in root of project for the full text.
