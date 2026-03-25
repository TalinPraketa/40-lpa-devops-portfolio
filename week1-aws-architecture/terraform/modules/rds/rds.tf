resource "aws_db_subnet_group" "db_subnet" {
  subnet_ids = var.private_subnets
}

resource "aws_db_instance" "db" {
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  username             = var.db_username
  password             = var.db_password

  db_subnet_group_name = aws_db_subnet_group.db_subnet.name

  vpc_security_group_ids = [var.app_sg_id]

  skip_final_snapshot = true
}