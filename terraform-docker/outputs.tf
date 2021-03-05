//output "container-name" {
//  value = module.container[each.key].container-name
//  description = "logical name of the docker container(s) in module.container"
//}
//
//output "ip-address" {
//  #value = [for i in docker_container.nodered_container[*]:join(":",[i.ip_address], i.ports[*]["external"])]
//  value = flatten(module.container[each.key].ip-address)
//  description = "Host ports for nodered docker containers in  module.container"
//}