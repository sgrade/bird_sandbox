// VPC, subnets and network-related resources

resource "aws_vpc" "sandbox_vpc" {
  
  cidr_block            = var.vpc_cidr_block
  instance_tenancy      = "default"
  // True so, instances are accessible from Internet
  enable_dns_hostnames  = true

  tags = var.resource_tags
}

# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"

  // Only Availability Zones (no Local Zones):
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

// +++++++++++++++++++
// Private subnets

// Between host 1 and 2
resource "aws_subnet" "sandbox_private_subnet_12" {
  vpc_id                  = aws_vpc.sandbox_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.sandbox_vpc.cidr_block, 8, 12)
  // False, so instances are not accessible from Internet
  map_public_ip_on_launch = false

  availability_zone = data.aws_availability_zones.available.names[0]

  tags = var.resource_tags
}

// Between host 1 and 3
resource "aws_subnet" "sandbox_private_subnet_13" {
  vpc_id                  = aws_vpc.sandbox_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.sandbox_vpc.cidr_block, 8, 13)
  // False, so instances are not accessible from Internet
  map_public_ip_on_launch = false

  availability_zone = data.aws_availability_zones.available.names[0]

  tags = var.resource_tags
}

// Between host 2 and 3
resource "aws_subnet" "sandbox_private_subnet_23" {
  vpc_id                  = aws_vpc.sandbox_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.sandbox_vpc.cidr_block, 8, 23)
  // False, so instances are not accessible from Internet
  map_public_ip_on_launch = false

  availability_zone = data.aws_availability_zones.available.names[0]

  tags = var.resource_tags
}

// +++++++++++++++++++
// Internet access

resource "aws_internet_gateway" "sandbox_gw" {
  vpc_id = aws_vpc.sandbox_vpc.id
  tags = var.resource_tags
}

resource "aws_subnet" "sandbox_public_subnet_1" {
  vpc_id                  = aws_vpc.sandbox_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.sandbox_vpc.cidr_block, 8, 0)
  // True, so instances are accessible from Internet
  map_public_ip_on_launch = true

  availability_zone = data.aws_availability_zones.available.names[0]

  tags = var.resource_tags
}

resource "aws_route_table" "sandbox_public" {
  vpc_id = aws_vpc.sandbox_vpc.id
  tags = var.resource_tags
}

// Subnets that are not explicitely associated with some subnet will be associated with main route table
resource "aws_route_table_association" "sandbox_public" {
  subnet_id      = aws_subnet.sandbox_public_subnet_1.id
  route_table_id = aws_route_table.sandbox_public.id
}

resource "aws_route" "sandbox_public_subnet_to_internet" {
  destination_cidr_block    = "0.0.0.0/0"
  route_table_id            = aws_route_table.sandbox_public.id
  gateway_id                = aws_internet_gateway.sandbox_gw.id
}

/*
resource "aws_route" "sandbox_main_rt_to_instance" {
  destination_cidr_block    = "0.0.0.0/0"
  route_table_id            = aws_vpc.sandbox_vpc.main_route_table_id
  // instance_id                = aws_instance.debian1.id
}
*/
