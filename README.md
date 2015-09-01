# About this repository

This repository is responsible to create the lightblue project deploy on any machine using Docker.

# Roadmap

You can see what we are looking foward with this repository looking at the [Roadmap.md](https://github.com/lightblue-platform/lightblue-dockerfile/blob/master/Roadmap.md) file.

# Requirements

For this repository you will need to have [Docker](https://www.docker.com/) and [Docker Compose](http://docs.docker.com/compose/) installed.

# How to run

Just clone this repository, cd to a subdirectory reprsenting the lightblue version you want to boot, and run `docker-compose up`.

Once started, you will have following services available:

* Data endpoint: http://localhost:8080/rest/data
* Metadata endpoint: http://localhost:8080/rest/metadata
* Data Management App: http://localhost:8081/app/data
* Metadata Management App: http://localhost:8081/app/metadata

## Running without docker-compose
Docker-compose does not work everywhere (at the time of writing, it's broken on Fedora 22). Here is how you can link lightblue containers togeather using only docker:
```
docker run -d --name mongodb docker.io/mongo mongod --rest --httpinterface --smallfiles
docker run -d -p 8080:8080 -p 9999:9999 --name lightblue --link mongodb:mongodb docker.io/lightblue/lightblue /opt/jbossas7/bin/standalone.sh -b 0.0.0.0 -Djboss.bind.address.management=0.0.0.0
```

See [dockerlinks](https://docs.docker.com/userguide/dockerlinks/) documentation for detauls. **WARNING**: Until fixed, [linking does not work on Fedora 22](https://forums.docker.com/t/docker-update-on-fedora-22-can-not-link-containers/2484)! Adjust firewall settings: ```sudo iptables -A DOCKER -p tcp -j ACCEPT```.

# Books!

* [Overview](http://jewzaam.gitbooks.io/lightblue/)
* [User Guide](http://jewzaam.gitbooks.io/lightblue-user-guide/)
* [Developer Manual](http://jewzaam.gitbooks.io/lightblue-developer-manual/)


# License

The license of lightblue is [GPLv3](https://www.gnu.org/licenses/gpl.html).  See LICENSE in root of project for the full text.
