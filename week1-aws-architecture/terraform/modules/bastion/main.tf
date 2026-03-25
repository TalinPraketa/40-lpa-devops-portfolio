resource "aws_instance" "bastion" {
  ami           = "ami-05d2d839d4f73aafb"
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet

  key_name = "terraform-key"

  vpc_security_group_ids = [var.bastion_sg_id]

  tags = {
    Name = "bastion-host"
  }
}
