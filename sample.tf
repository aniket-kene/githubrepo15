provider "aws" {
  region = "us-east-1"   # N. virginia
}
terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket"   # Replace with your S3 bucket name
    key    = "terraform.tfstate"  # Replace with your desired state file path
    region = "us-east-1"   # N. virginia  
  }
}
resource "aws_instance" "my_instance" {
  ami = "ami-068c0051b15cdb816"   # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t3.micro"
  vpc_security_group_ids = ["sg-029323b0aa9acf519"]  # Replace with your security group ID
  availability_zone = "us-east-1a"
  key_name = "Teraformkey"   # Replace with your key pair name

  tags = {
    Name = "Myfirst_Instance"
  }
}