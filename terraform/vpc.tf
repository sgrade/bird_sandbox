// VPC, subnets and network-related resources

resource "aws_vpc" "sandbox_vpc" {
  
  cidr_block            = var.vpc_cidr_block
  instance_tenancy      = "default"
  // True so, instances are accessible from Internet
  enable_dns_hostnames  = true

  assign_generated_ipv6_cidr_block = true

  /*
  // For IPAM - see ipam.tf for details
  ipv6_cidr_block       = aws_vpc_ipam_pool_cidr.sandbox_ipv6_public.id
  ipv6_ipam_pool_id     = aws_vpc_ipam_pool.sandbox_pool.id
  */

  tags = var.resource_tags
}

data "aws_vpc" "sandbox_vpc" {
  id = aws_vpc.sandbox_vpc.id
}

// For the subnets to be in the same availability zone. Otherwise the deployment will fail.
// Declare the data source
data "aws_availability_zones" "available" {
  state = "available"

  // Only Availability Zones (no Local Zones):
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}
