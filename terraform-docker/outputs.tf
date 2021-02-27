output "container-name" {
  value = docker_container.nodered_container[*].name
  description = "logical name of the docker container"
}

output "ip-address" {
  #value = [for i in docker_container.nodered_container[*]:join(":",[i.ip_address], i.ports[*]["external"])]
  value = [for i in docker_container.nodered_container[*]:join(":",[i.ip_address, i.ports[0]["external"]])]
  description = "Host ports for nodered docker containers"
}