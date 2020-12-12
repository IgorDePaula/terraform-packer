terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}
data "aws_ami" "web" {
owners = ["self"]
  
  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "tag:name"
    values = ["packer-image"]
  }
  
  

  most_recent = true
}
provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "example" {
  ami           =  data.aws_ami.web.id
  instance_type = "t2.micro"
}


output "ip" {
  value = aws_instance.example.public_ip
}
