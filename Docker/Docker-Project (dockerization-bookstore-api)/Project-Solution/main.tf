terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.40.0"
    }
    github = {
      source = "integrations/github"
      version = "6.0.1"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

provider "github" {
  # Configuration options
  token = "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"
}

resource "github_repository" "myrepo" {
  name        = "bookstore-api-2"
  description = "My awesome project"
  visibility = "private"
  auto_init   = true
}
resource "github_branch_default" "main"{
  repository = github_repository.myrepo.name
  branch     = "main"
}

variable "files"{
    default = ["bookstore-api.py" , "requirements.txt" , "Dockerfile", "docker-compose.yml"]
}

resource "github_repository_file" "app-files" {
  for_each            = toset(var.files)    
  content             = file(each.value)  
  file                = each.value 
  repository          = github_repository.myrepo.name
  branch              = "main"
  commit_message      = "Managed by Terraform"
  overwrite_on_create = true
}

resource "aws_instance" "tf-docker-ec2" {
    ami = "ami-00c39f71452c08778"
    instance_type = "t2.micro"
    key_name = "rahmatullah_key"
    vpc_security_group_ids = [aws_security_group.allow_ssh.id]
    tags = {
        Name = "Bookstore Web Server"
    }
    user_data = <<-EOF
          #! /bin/bash
          yum update -y
          yum install python3-pip
          yum install docker git -y
          systemctl start docker
          systemctl enable docker
          usermod -a -G docker ec2-user
          newgrp docker
          curl -SL https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
          chmod +x /usr/local/bin/docker-compose
          mkdir -p /home/ec2-user/bookstore-api-2
          TOKEN="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"
          cd /home/ec2-user
          git clone https://$TOKEN@github.com/RahmatullahF/bookstore-api-2.git
          cd /home/ec2-user/bookstore-api-2
          docker-compose up -d
          EOF
    depends_on = [github_repository.myrepo,github_repository_file.app-files]
    
}
locals {
  instance-type = "t2.micro"
  secgr-dynamic-ports = [22,80,443,8080,5000]
  user = "Project"
}

resource "aws_security_group" "allow_ssh" {
  name        = "${local.user}-docker-instance-sg"
  description = "Allow SSH inbound traffic"
  dynamic "ingress" {
    for_each = local.secgr-dynamic-ports
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}
  egress {
    description = "Outbound Allowed"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "website" {
    value = "http://${aws_instance.tf-docker-ec2.public_dns}"
}