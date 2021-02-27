terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.11.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "node-red_image" {
  name = lookup(var.image, var.env)
}

resource "null_resource" "dockervol" {
  provisioner "local-exec" {
    command = "mkdir node_red_data/ || true"
  }
}

resource "docker_container" "nodered_container" {
  count = local.container_count
  name  = join("-", ["nodered", random_string.random[count.index].result])
  image = docker_image.node-red_image.latest
  ports {
    internal = var.int_port
    //external = var.ext_port[count.index]
    //external = lookup(var.ext_port, var.env)[count.index]
    external = var.ext_port[terraform.workspace][count.index]
  }
  volumes {
    container_path = "/data"
    host_path = "${path.cwd}/node_red_data"
  }
}

resource "random_string" "random" {
  count   = local.container_count
  length  = 4
  special = false
  upper   = false
}

//don't need this now that we have a port list
//resource "random_integer" "ext-port" {
//  count   = var.container_count
//  min = 1
//  max = 6535
//}


