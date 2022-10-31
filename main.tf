terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "Fany-dev-vpc" {
  cidr_block = "10.0.0.0/27"
  tags = {
    "Name" = "Fany-dev-vpc"
  }
}

resource "aws_subnet" "Fany-k8s-subnet" {
  vpc_id     = aws_vpc.Fany-dev-vpc.id
  cidr_block = "10.0.0.0/27"

  tags = {
    Name = "Fany-k8s-subnet"
  }
}

  resource "aws_internet_gateway" "Fany_gw" {
  vpc_id = aws_vpc.Fany-dev-vpc.id

  tags = {
    Name = "Fany_gw"
  }
}

resource "aws_route" "routeIGW" {
  route_table_id         = aws_vpc.Fany-dev-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.Fany_gw.id
}

 
