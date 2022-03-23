terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = "~>1.0"
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = {
        owner = var.owner_tag
    }
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_ec2_instance_types" "free_tier_inst_type" {
    filter {
        name   = "free-tier-eligible"
        values = ["true"]
    }

}

resource "aws_instance" "web" {

  ami           = data.aws_ami.ubuntu.id
  instance_type = data.aws_ec2_instance_types.free_tier_inst_type.instance_types[0]
  key_name = var.my_key_name
  security_groups = [ var.sg_name ]
  user_data = "${file("user_data.sh")}"


  tags = {
    Name = "sgoryunov"
  }
  volume_tags = {
    "owner" = var.owner_tag
  }
}

# resource "aws_db_instance" "my_db" {
#   allocated_storage    = 10
#   engine               = "mysql"
#   engine_version       = "5.7"
#   instance_class       = "db.t3.micro"
#   name                 = "mydb"
#   username             = "foo"
#   password             = "foobarbaz"
#   parameter_group_name = "default.mysql5.7"
#   skip_final_snapshot  = true
# }