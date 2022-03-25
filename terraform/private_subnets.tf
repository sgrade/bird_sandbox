
// Private subnets

// Between host 1 and 2
resource "aws_subnet" "sandbox_private_subnet_12" {
  vpc_id                  = aws_vpc.sandbox_vpc.id
  
  cidr_block              = cidrsubnet(aws_vpc.sandbox_vpc.cidr_block, 8, 12)
  // False, so instances are not accessible from Internet
  map_public_ip_on_launch = false

  // the VPC subnets are /64 fixed in length.
  // https://d1.awsstatic.com/whitepapers/IPv6-on-AWS.pdf
  ipv6_cidr_block = cidrsubnet(data.aws_vpc.sandbox_vpc.ipv6_cidr_block, 8, 12)

  availability_zone = data.aws_availability_zones.available.names[0]

  tags = var.resource_tags
}

// Between host 1 and 3
resource "aws_subnet" "sandbox_private_subnet_13" {
  vpc_id                  = aws_vpc.sandbox_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.sandbox_vpc.cidr_block, 8, 13)
  // False, so instances are not accessible from Internet
  map_public_ip_on_launch = false

  // the VPC subnets are /64 fixed in length.
  // https://d1.awsstatic.com/whitepapers/IPv6-on-AWS.pdf
  ipv6_cidr_block = cidrsubnet(data.aws_vpc.sandbox_vpc.ipv6_cidr_block, 8, 13)

  availability_zone = data.aws_availability_zones.available.names[0]

  tags = var.resource_tags
}

// Between host 2 and 3
resource "aws_subnet" "sandbox_private_subnet_23" {
  vpc_id                  = aws_vpc.sandbox_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.sandbox_vpc.cidr_block, 8, 23)
  // False, so instances are not accessible from Internet
  map_public_ip_on_launch = false

  // the VPC subnets are /64 fixed in length.
  // https://d1.awsstatic.com/whitepapers/IPv6-on-AWS.pdf
  ipv6_cidr_block = cidrsubnet(data.aws_vpc.sandbox_vpc.ipv6_cidr_block, 8, 23)

  availability_zone = data.aws_availability_zones.available.names[0]

  tags = var.resource_tags
}
