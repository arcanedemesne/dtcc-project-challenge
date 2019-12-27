provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "instance" {
  name = "dtcc-project-challenge-instance"
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "dtcc-project-challenge" {
  ami           = "ami-b374d5a5"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Terraform for the People" > index.html
              nohup busybox httpd -f -p 80 &
              EOF
  
  tags = {
    Name = "dtcc-project-challenge"
  }
}