output "Bastion-server_ip" {
  value = module.compute.bastion_public_ip
}

output "Web-VM_ip" {
  value = module.compute.web_public_ip
}

output "App-VM_ip" {
  value = module.compute.app_private_ip
}

output "DB-VM_ip" {
  value = module.compute.db_private_ip
}
