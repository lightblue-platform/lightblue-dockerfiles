# Configure the Docker provider
provider "docker" {
        host = "tcp://127.0.0.1:4243/"
}

# Create a mongo container
resource "docker_container" "mongo" {
        image = "${docker_image.mongo.latest}"
        name = "lbmongo"
        command = ["mongod", "--rest", "--httpinterface", "--smallfiles"]
}

# Create a lightblue container
resource "docker_container" "lightblue" {
        image = "${docker_image.lightblue.latest}"
        name = "lightblue"
        ports {
           "internal" = "8080"
           "external" = "${var.lightblue_port}"
        }
        ports {
           "internal" = "9999"
           "external" = "9999"
        }
        links = ["lbmongo:mongodb"]
        command = ["/opt/jbossas7/bin/standalone.sh", "-b", "0.0.0.0", "-Djboss.bind.address.management=0.0.0.0"]
        depends_on = ["docker_container.mongo"]
}

# Create a lightblue applications container
resource "docker_container" "lightblue_apps" {
        image = "${docker_image.lightblue_apps.latest}"
        name = "lightblue_apps"
        ports {
           "internal" = "8080"
           "external" = "${var.lightblue_apps_port}"
        }
        links = ["lightblue:lightblue"]
        command = ["/opt/jbossas7/bin/standalone.sh", "-b", "0.0.0.0"]
        depends_on = ["docker_container.lightblue"]
}

resource "docker_image" "mongo" {
        name = "docker.io/mongo:latest"
}

resource "docker_image" "lightblue" {
        name = "docker.io/lightblue/lightblue:${var.lightblue_version}"
}

resource "docker_image" "lightblue_apps" {
        name = "docker.io/lightblue/applications:${var.lightblue_apps_version}"
}

variable "lightblue_version" {
    default = "latest"
}


variable "lightblue_port" {
    default = "8080"
}

variable "lightblue_apps_version" {
    default = "latest"
}

variable "lightblue_apps_port" {
    default = "8081"
}
