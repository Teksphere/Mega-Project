provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "mydevops_vpc" {
 cidr_block = "10.0.0.0/16"

 tags = {
   Name = "mydevops_vpc"
 }
}

resource "aws_subnet" "mydevops_subnet" {
  count = 2
  vpc_id = aws_vpc.mydevops_vpc.vpc_id
  cidr_block = cidrsubnet(aws_vpc.mydevops_vpc.cidr_block, 8, count.index)
  availability_zone = element(["us-east-1a", "us-east-1b"], count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "mydevops-subnet-${count.index}"
  }
}