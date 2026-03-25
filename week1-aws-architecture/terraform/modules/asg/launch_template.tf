resource "aws_launch_template" "app_lt" {
  name_prefix   = "app-lt"
  image_id      = "ami-05d2d839d4f73aafb"
  instance_type = "t3.micro"

  vpc_security_group_ids = [var.app_sg_id]

  user_data = base64encode(<<-EOF
#!/bin/bash
apt-get update -y
apt-get install -y apache2
systemctl start apache2
systemctl enable apache2
echo "Hello from ASG - Talin" > /var/www/html/index.html
EOF
  )
}
