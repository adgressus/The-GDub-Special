resource "aws_security_group" "mybastionsg" {
  name        = "${var.project_name}-bastion-security-group"
  description = "${var.project_name} ssh bastion security group"
  vpc_id      = aws_vpc.myvpc.id
  tags        = var.default_tags

  ingress {
    protocol         = "tcp"
    from_port        = 22
    to_port          = 22
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol    = "-1" # All traffic
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  depends_on = [aws_vpc.myvpc]
}

resource "aws_security_group" "myinstancesg" {
  name        = "${var.project_name}-instance-security-group"
  description = "${var.project_name} instance security group"
  vpc_id      = aws_vpc.myvpc.id
  tags        = var.default_tags

  ingress {
    protocol        = "tcp"
    from_port       = 22
    to_port         = 22
    security_groups = [aws_security_group.mybastionsg.id]
  }

  egress {
    protocol    = "-1" # All traffic
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  depends_on = [aws_security_group.mybastionsg]
}


# finds the id of the most recent EBS optimized AL2 OS image
data "aws_ami" "mybastionami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

resource "aws_instance" "mybastion" {
  ami                         = data.aws_ami.mybastionami.image_id
  key_name                    = aws_key_pair.mykeypair.key_name
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.mybastionsg.id]
  associate_public_ip_address = true

  tags = var.default_tags

  depends_on = [aws_security_group.mybastionsg]
}