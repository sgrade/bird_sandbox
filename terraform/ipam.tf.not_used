// IPAM is required to bring our own IPv6 CIDR
// https://docs.aws.amazon.com/vpc/latest/ipam/tutorials-byoip-ipam-ipv6.html

// NOT IPMLEMENTED because of the following:
//   "Note that it can take up to one week for the BYOIP CIDR to be provisioned."
//   https://docs.aws.amazon.com/vpc/latest/ipam/tutorials-byoip-ipam-ipv6.html#tutorials-byoip-ipam-ipv6-4
// Left in the repo for compatibility with enterprise environments, where IPAM is used. 
// NOT finished: extra work is required.

data "aws_region" "current" {}

resource "aws_vpc_ipam" "sandbox_ipam" {
  description = "Sandbox IPAM"
  operating_regions {
    region_name = data.aws_region.current.name
  }

  tags = merge(
    {
      Name = "Sandbox IPAM"
    },
    var.resource_tags
  )
}

resource "aws_vpc_ipam_pool" "sandbox_pool" {
  address_family = "ipv6"
  ipam_scope_id  = aws_vpc_ipam.sandbox_ipam.public_default_scope_id
  locale         = data.aws_region.current.name
  description    = "Top level IPv6 pool"
  // advertisable   = false
  aws_service    = "ec2"

  tags = merge(
    {
      Name = "Sandbox IPAM pool"
    },
    var.resource_tags
  )
}

resource "aws_vpc_ipam_pool_cidr" "sandbox_ipv6_public" {
  ipam_pool_id = aws_vpc_ipam_pool.sandbox_pool.id
  // Note that when provisioning an IPv6 CIDR to a pool within the top-level pool, 
  //   the minimum IPv6 CIDR you can provision for an advertisable IPAM pool is /48; 
  //   more specific CIDRs (such as /49) are not permitted.
  // https://docs.aws.amazon.com/vpc/latest/ipam/tutorials-byoip-ipam-ipv6.html#tutorials-byoip-ipam-ipv6-2
  cidr         = var.ipv6_ula_prefix
  
  /*
  // Terraform error: An argument named "tags" is not expected here.
  tags = merge(
    {
      Name = "IPAM IPv6 CIDR"
    },
    var.resource_tags
  )
  */
}
