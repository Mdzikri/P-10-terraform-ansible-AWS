terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
    access_key = " "
    secret_key = " "
    region = "ap-southeast-2"
}
resource "aws_security_group" "allow_tls" {
  name        = "for_project"
  description = "Allow TLS inbound traffic"
  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

//instance
resource "aws_instance" "ec2-1" {
  ami = "ami-05f998315cca9bfe3"
  instance_type = "t2.micro"
  key_name = "sy-key"
}

//RDS
resource "aws_db_instance" "cilist" {
  engine = "mysql"
  engine_version = "8.0.32"
  identifier = "database"
  username = "admin"
  password = "ifsaktii"
  instance_class = "db.t3.small"
  publicly_accessible = true
  allocated_storage = 20
  skip_final_snapshot = true
}

output "ec2" {
  value = aws_instance.ec2-1.public_ip
}
output "db" {
  value = aws_db_instance.cilist.endpoint
}
