locals {
  instance_name = "myfirst-instance"
}
terraform {
  backend "s3" {
    bucket = "terraform-state-bucket1.1"
    region = "us-east-1"
    key = "terraform.tfstate"
  }
}
data "aws_security_group" "mysg" {
  filter {
    name   = "vpc-id"
    values =[var.vpc_id]
  }
  filter {
    name   = "group-name"
    values = ["mysg"]
  }
}
resource "aws_instance" "myinstance" {
  ami = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.mysg.id]
  key_name = var.key_name
  tags = {
    Name = local.instance_name
  }
} 