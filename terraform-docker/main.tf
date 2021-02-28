resource "null_resource" "dockervol" {
  provisioner "local-exec" {
    command = "mkdir node_red_data/ || true"
  }
}

resource "random_string" "random" {
  count   = local.container_count
  length  = 4
  special = false
  upper   = false
}

module "image" {
  source = "./image"
  image_in = var.image[terraform.workspace]
}

module "container" {
  source = "./container"
  count = local.container_count
  depends_on = [null_resource.dockervol]
  name_in = join("-", ["nodered", null_resource.dockervol.id, random_string.random[count.index].result])
  image_in = module.image.image_out
  int_port_in = var.int_port
  ext_port_in = var.ext_port[terraform.workspace][count.index]
  container_path_in = "/data"
  host_path_in = "${path.cwd}/node_red_data"
}


