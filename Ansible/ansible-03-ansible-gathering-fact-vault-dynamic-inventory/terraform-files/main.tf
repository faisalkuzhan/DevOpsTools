
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
  # secret_key = ""
  # access_key = ""
}

resource "aws_instance" "nodes" {
  ami = var.myami
  instance_type = var.instancetype
  count = var.num
  key_name = var.mykey
  vpc_security_group_ids = [aws_security_group.tf-sec-gr.id]
  tags = {
    Name = "${element(var.tags1, count.index)}"
    Environment= "${element(var.tags2, count.index)}"
  }
}

resource "aws_security_group" "tf-sec-gr" {
  name = "ansible-lesson3-sec-gr"
  tags = {
    Name = "ansible-session3-sec-gr"
  }

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = -1
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "null_resource" "config" {
  depends_on = [aws_instance.nodes[0]]
  connection {
    host = aws_instance.nodes[0].public_ip
    type = "ssh"
    user = "ec2-user"
    private_key = file("${var.mykeypath}")
  }

  provisioner "file" {
    source = "./ansible.cfg"
    destination = "/home/ec2-user/ansible.cfg"
  }

  provisioner "file" {
    # Do not forget to define your key file path correctly!
    source = "${var.mykeypath}"
    destination = "/home/ec2-user/${var.mykey}.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname Control-Node",
      "sudo dnf update -y",
      "curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py",
      "python3 get-pip.py --user",
      "pip3 install --user ansible",
      "echo [webservers] >> inventory.txt",
      "echo node1 ansible_host=${aws_instance.nodes[1].private_ip} ansible_ssh_private_key_file=/home/ec2-user/${var.mykey}.pem ansible_user=ec2-user >> inventory.txt",
      "echo [dbservers] >> inventory.txt",
      "echo node2 ansible_host=${aws_instance.nodes[2].private_ip} ansible_ssh_private_key_file=/home/ec2-user/${var.mykey}.pem ansible_user=ec2-user >> inventory.txt",
      "chmod 400 ${var.mykey}.pem"
    ]
  }
}

output "controlnodeip" {
  value = aws_instance.nodes[0].public_ip
}