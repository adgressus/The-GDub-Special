output "bastion_dns" {
  value = aws_instance.mybastion.public_dns
}

output "instance_dns" {
  value = aws_instance.myinstance.private_dns
}

output "public_key" {
  value = "${var.short_project_name}Key.pem"
}