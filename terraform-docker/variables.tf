variable "env" {
  type = string
  default = "dev"
  description = "Env to deploy to"
}

variable "image" {
  type = map
  description = "Node-RED docker image to deploy"
  default = {
    dev = "nodered/node-red:latest"
    prod = "nodered/node-red:latest-minimal"
  }
}

variable "ext_port" {
  type = map
  //default = 1880

  //commenting out to play with local values
  //validation {
  //  condition = var.ext_port <= 65535 && var.ext_port > 0
  //  error_message = "Exp port must be between 0 and 65535."
  //}

  //validation {
  //  condition = max(var.ext_port...) <= 65535 && min(var.ext_port...) > 0
  //  error_message = "Exp port must be between 0 and 65535."
  //}

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

//commenting out to play with local values
//variable "container_count" {
//    type = number
//    default = 4
//}

locals {
    container_count = length(var.ext_port[terraform.workspace])
}
