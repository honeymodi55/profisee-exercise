########## creating IG and NAT Gateway for VPC ##########
## Internet Gateway ## 
resource "aws_internet_gateway" "profiseeIG" {
    vpc_id = aws_vpc.profiseeVPC.id
    tags = {
      Name = "profisee-ig"
    }
}

## NAT Gateway ##
# Nat Gateway uses Elastic IP 
resource "aws_eip" "profiseeEIP" {
    tags = {
      Name = "profisee-eip"
    }
}
resource "aws_nat_gateway" "profiseeNAT" {
    allocation_id = aws_eip.profiseeEIP.id
    subnet_id = aws_subnet.publicSubnet.id
    tags = {
      Name = "profisee-nat-gateway"
    }
    depends_on = [ aws_internet_gateway.profiseeIG, aws_eip.profiseeEIP ]
}

########## creating VPC ##########
resource "aws_vpc" "profiseeVPC" {
    cidr_block = "10.224.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        Name = "profisee-vpc"
    }
}

######### creating subnets for VPC ##########
## Public Subnet ##
resource "aws_subnet" "publicSubnet" {
    vpc_id = aws_vpc.profiseeVPC.id
    cidr_block = "10.224.1.0/24"
    availability_zone = "us-west-2a"
    tags = {
      Name = "public-subnet"
    }
}
## Private Subnet ##
resource "aws_subnet" "privateSubnet" {
    vpc_id = aws_vpc.profiseeVPC.id
    cidr_block = "10.224.2.0/24"
    availability_zone = "us-west-2a"
    tags = {
      Name = "private-subnet"
    }
}

######### creating route tables ##########
## Route Table for public subnet ##
resource "aws_route_table" "publicRoutetb" {
  vpc_id = aws_vpc.profiseeVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.profiseeIG.id
  }
  tags = {
    Name = "publicRtb"
  }
}

## Route Table for public subnet ##
resource "aws_route_table" "privateRoutetb" {
  vpc_id = aws_vpc.profiseeVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.profiseeNAT.id
  }
  tags = {
    Name = "privateRtb"
  }
}

######### creating route table associations with subnet #########
## Route Table Association for PublicSubnet ##
resource "aws_route_table_association" "publicRtbAssociation" {
  subnet_id = aws_subnet.publicSubnet.id
  route_table_id = aws_route_table.publicRoutetb.id
}

## Route Table Association for PrivateSubnet ##
resource "aws_route_table_association" "privateRtbAssociation" {
  subnet_id = aws_subnet.privateSubnet.id
  route_table_id = aws_route_table.privateRoutetb.id
}

########## showing the output on terminal ##########
output "vpc_id" {
  value = aws_vpc.profiseeVPC.id
}
output "public_subnet_id" {
  value = aws_subnet.publicSubnet.id
}
output "private_subnet_id" {
  value = aws_subnet.privateSubnet.id
}