########## creating IG and NAT Gateway for VPC ##########
## Internet Gateway ## 
resource "aws_internet_gateway" "profiseeIG" {
    vpc_id = aws_vpc.profiseeVPC.id
    tags = {
      Name = "profisee-ig"
    }
}

## NAT Gateway (just adding a comment) ##
# Nat Gateway uses Elastic IP 
resource "aws_eip" "profiseeEIP" {
    tags = {
      Name = "profisee-eip"
    }
}
resource "aws_nat_gateway" "profiseeNAT" {
    allocation_id = aws_eip.profiseeEIP.id
    subnet_id = aws_subnet.publicSubnetA.id
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
resource "aws_subnet" "publicSubnetA" {
    vpc_id = aws_vpc.profiseeVPC.id
    cidr_block = "10.224.1.0/24"
    availability_zone = "us-west-2a"
    tags = {
      Name = "public-subnet-a"
    }
}
resource "aws_subnet" "publicSubnetB" {
    vpc_id = aws_vpc.profiseeVPC.id
    cidr_block = "10.224.2.0/24"
    availability_zone = "us-west-2b"
    tags = {
      Name = "public-subnet-b"
    }
}
## Private Subnet ##
resource "aws_subnet" "privateSubnetA" {
    vpc_id = aws_vpc.profiseeVPC.id
    cidr_block = "10.224.3.0/24"
    availability_zone = "us-west-2a"
    tags = {
      Name = "private-subnet-a"
    }
}
resource "aws_subnet" "privateSubnetB" {
    vpc_id = aws_vpc.profiseeVPC.id
    cidr_block = "10.224.4.0/24"
    availability_zone = "us-west-2b"
    tags = {
      Name = "private-subnet-b"
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
## Route Table Association for PublicSubnetA ##
resource "aws_route_table_association" "publicRtbAssociationA" {
  subnet_id = aws_subnet.publicSubnetA.id
  route_table_id = aws_route_table.publicRoutetb.id
}
## Route Table Association for PublicSubnetB ##
resource "aws_route_table_association" "publicRtbAssociationB" {
  subnet_id = aws_subnet.publicSubnetB.id
  route_table_id = aws_route_table.publicRoutetb.id
}

## Route Table Association for PrivateSubnetA ##
resource "aws_route_table_association" "privateRtbAssociationA" {
  subnet_id = aws_subnet.privateSubnetA.id
  route_table_id = aws_route_table.privateRoutetb.id
}
## Route Table Association for PrivateSubnetB ##
resource "aws_route_table_association" "privateRtbAssociationB" {
  subnet_id = aws_subnet.privateSubnetB.id
  route_table_id = aws_route_table.privateRoutetb.id
}