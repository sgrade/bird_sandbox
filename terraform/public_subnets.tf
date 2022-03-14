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
