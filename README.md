# About this repository

This repository is responsible to create the lightblue project deploy on any machine using Docker.

NOTE: As the firsts iterations we are going to use an image from our internal Docker repository because we are going to deploy using Red Hat JBoss EAP. There is a problem need to be solved to lightblue work with Wildfly right now, you can contribute solving this issue so we can remove the internal dependency (More about it on http://forum.lightblue.io/Unable-to-deploy-lightblue-on-wildfly-td4.html#a7 ).

# Roadmap

You can see what we are looking foward with this repository looking at the [Roadmap.md](https://github.com/lightblue-platform/lightblue-dockerfile/blob/master/Roadmap.md) file.

# Requirements

For this repository you will need to have [Docker](https://www.docker.com/) and [Fig](http://www.fig.sh/) installed. 

# How to run

Just clone this repository and inside this folder run `fig up`.

# Books!

* [Overview](http://jewzaam.gitbooks.io/lightblue/)
* [User Guide](http://jewzaam.gitbooks.io/lightblue-user-guide/)
* [Developer Manual](http://jewzaam.gitbooks.io/lightblue-developer-manual/)


# License

The license of lightblue is [GPLv3](https://www.gnu.org/licenses/gpl.html).  See LICENSE in root of project for the full text.
