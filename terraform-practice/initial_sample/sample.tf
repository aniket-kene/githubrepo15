locals {
  instance_name = "Myfirst_Instance"
}
provider "aws" {
  region = "us-east-1"   # N. virginia
}
terraform {
  backend "s3" {
    bucket = "terraform-state-bucket1.1"   # Replace with your S3 bucket name
    key    = "terraform.tfstate"  # Replace with your desired state file path
    region = "us-east-1"   # N. virginia  
  }
}
resource "aws_instance" "my_instance" {
  ami = "var.ami_id"   # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "var.instance_type"  # t3.micro
  vpc_security_group_ids = ["var.security_group_id"]  # Replace with your security group ID
  availability_zone = "var.availability_zone"  # us-east-1a
  key_name = "var.key_name"   # Replace with your key pair name

  tags = {
    Name = local.instance_name
  }
}
variable "ami_id" {
  default = "ami-068c0051b15cdb816"
}
variable "instance_type" {
  default = "t3.micro"
}
variable "availability_zone" {
  default = "us-east-1a"
}
variable "key_name" {
  default = "Teraformkey"
}
variable "security_group_id" {
  default = "sg-029323b0aa9acf519"
}
output "instance_public_ip" {
 aws_instance.my_instance.public_ip 
}
output "instance_id" {
 aws_instance.my_instance.id 
}
