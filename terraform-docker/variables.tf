variable "env" {
  type = string
  default = "dev"
  description = "Env to deploy to"
}

variable "image" {
  type = map
  description = "Node-RED docker image to deploy"
  default = {
    nodered = {
      dev = "nodered/node-red:latest"
      prod = "nodered/node-red:latest-minimal"
    }
    influxdb = {
      dev = "quay.io/influxdb/influxdb:v2.0.2"
      prod = "quay.io/influxdb/influxdb:v2.0.2"
    }
  }
}

variable "ext_port" {
  type = map

  validation {
    condition = max(var.ext_port["dev"]...) <= 1999 && min(var.ext_port["dev"]...) > 1900
    error_message = "Exp port must be between 1900 and 1999."
  }

  validation {
    condition = max(var.ext_port["prod"]...) <= 1899 && min(var.ext_port["prod"]...) > 1800
    error_message = "Production external port must be between 1800 and 1899."
  }
}

variable "int_port" {
  type = number
  default = 1880

  validation {
    condition = var.int_port == 1880
    error_message = "Internal port must be port 1880."
  }
}

locals {
    container_count = length(var.ext_port[terraform.workspace])
}
