#----------------------------------------------------------
#
# My Terraform
#
#----------------------------------------------------------



provider "aws" {
    region = "us-east-1"
}


resource "aws_default_vpc" "default" {
}



resource "aws_instance" "myWebServer" {
  ami = "ami-005f9685cb30f234b"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.myWebServer.id]
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Bli",
    l_name = "Linux",
    names  = ["ubuntu", "mint", "debian", "manjaro", "arch", "fedora", "gentoo", "tails"]
  })

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "BliLinux"
  }

  lifecycle {
    create_before_destroy = true
  }

}


resource "aws_security_group" "myWebServer" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"
  vpc_id      = aws_default_vpc.default.id # This need to be added since AWS Provider v4.29+ to set VPC id


  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web Server SecurityGroup"
    Owner = "Denis Astahov"
  }
}
