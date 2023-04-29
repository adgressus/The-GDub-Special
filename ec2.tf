# finds the id of the most recent EBS optimized AL2 OS image
data "aws_ami" "myami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

resource "aws_instance" "myinstance" {
  ami                    = data.aws_ami.myami.image_id
  key_name               = aws_key_pair.mykeypair.key_name
  instance_type          = "m5.2xlarge"
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.myinstancesg.id]

  tags = var.default_tags

  depends_on = [aws_subnet.private]
}