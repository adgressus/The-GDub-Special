resource "tls_private_key" "mykey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


resource "aws_key_pair" "mykeypair" {
  key_name   = "${var.short_project_name}Key"
  public_key = tls_private_key.mykey.public_key_openssh

  tags = var.default_tags

  # Downloads key to local dir on linux/MacOs
  provisioner "local-exec" {
    command = "echo '${tls_private_key.mykey.private_key_pem}' > ./${var.short_project_name}Key.pem; chmod 400 ./${var.short_project_name}Key.pem"
  }
}

# Uncomment to download public key on windows
# resource "local_file" "mywindowskey" {
#   filename = "${var.key_pair_name}.pem"
#   file_permission = "0400"
#   content = tls_private_key.mykey.private_key_pem
# }