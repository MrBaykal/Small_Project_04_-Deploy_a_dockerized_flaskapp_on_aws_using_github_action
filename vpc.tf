# VPC
resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
      "Name" = "main-vpc"
    }
}

# Public Subnet
resource "aws_subnet" "public" {
    cidr_block = var.subnet_cidr_list[0]
    map_public_ip_on_launch = true   # map_public_ip_on_launch: Ensures that each new EC2 instance on the subnet is automatically assigned a public IP address.
    vpc_id = aws_vpc.main.id
    availability_zone = "${var.region}a"
}

# Internet gateaway to enable trafic from internet
resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
    tags = {
      "Name" = "main-IG"
    }
}

# Public route table
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    tags = {
      "Name" = "public-route"
    }    
}

# Associate public subnet to 
resource "aws_route_table_association" "public" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public.id
}

# route to internet gateway for public subnet
resource "aws_route" "public_internet_access" {
    route_table_id = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id  
}