// Network interfaces and their attachments to the instances

// +++++++++++++++++++
// Subnet between 1 and 2

locals {
    subnet_12_ips = [11, 22]
}

resource "aws_network_interface" "private_subnet_12" {
  count = 2
  subnet_id = aws_subnet.sandbox_private_subnet_12.id

  // Amazon reserves the first four (4) IP addresses and the last one (1) IP address of every subnet for IP networking purposes.
  // https://aws.amazon.com/vpc/faqs/#IP_Addressing
  private_ips = [cidrhost(aws_subnet.sandbox_private_subnet_12.cidr_block, local.subnet_12_ips[count.index])]

  ipv6_addresses = [cidrhost(aws_subnet.sandbox_private_subnet_12.ipv6_cidr_block, local.subnet_12_ips[count.index])]
  // Same effect as above
  // ipv6_address_list_enabled = true
  // ipv6_address_list = [cidrhost(aws_subnet.sandbox_private_subnet_12.ipv6_cidr_block, local.subnet_12_ips[count.index])]

  // Instances cannot act as routers without this
  // https://docs.aws.amazon.com/vpc/latest/userguide/VPC_NAT_Instance.html#EIP_Disable_SrcDestCheck
  source_dest_check = false

  tags = merge(
    {
      internal = true
    },
    var.resource_tags
  )
}

resource "aws_network_interface_attachment" "private_subnet_12_attachment" {
  count = 2
  instance_id          = "${aws_instance.router[count.index].id}"
  network_interface_id = aws_network_interface.private_subnet_12[count.index].id

  // IP addresses per network interface per instance type
  // https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-eni.html#AvailableIpPerENI
  device_index         = 1
}


// +++++++++++++++++++
// Subnet between 2 and 3

locals {
    subnet_23_ips = [22, 33]
}

resource "aws_network_interface" "private_subnet_23" {
  count = 2
  subnet_id = aws_subnet.sandbox_private_subnet_23.id

  // Amazon reserves the first four (4) IP addresses and the last one (1) IP address of every subnet for IP networking purposes.
  // https://aws.amazon.com/vpc/faqs/#IP_Addressing
  private_ips = [cidrhost(aws_subnet.sandbox_private_subnet_23.cidr_block, local.subnet_23_ips[count.index])]

  ipv6_addresses = [cidrhost(aws_subnet.sandbox_private_subnet_23.ipv6_cidr_block, local.subnet_23_ips[count.index])]
  // Same effect as above
  // ipv6_address_list_enabled = true
  // ipv6_address_list = [cidrhost(aws_subnet.sandbox_private_subnet_23.ipv6_cidr_block, local.subnet_23_ips[count.index])]

  // Instances cannot act as routers without this
  // https://docs.aws.amazon.com/vpc/latest/userguide/VPC_NAT_Instance.html#EIP_Disable_SrcDestCheck
  source_dest_check = false

  tags = merge(
    {
      internal = true
    },
    var.resource_tags
  )
}

resource "aws_network_interface_attachment" "private_subnet_23_attachment" {
  count                = 2
  instance_id          = "${aws_instance.router[count.index+1].id}"
  network_interface_id = aws_network_interface.private_subnet_23[count.index].id

  // IP addresses per network interface per instance type
  // https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-eni.html#AvailableIpPerENI
  device_index         = 2
}


// +++++++++++++++++++
// Subnet between 1 and 3

locals {
    subnet_13_ips = [11, 33]
}

resource "aws_network_interface" "private_subnet_13" {
  count = 2
  subnet_id = aws_subnet.sandbox_private_subnet_13.id

  // Amazon reserves the first four (4) IP addresses and the last one (1) IP address of every subnet for IP networking purposes.
  // https://aws.amazon.com/vpc/faqs/#IP_Addressing
  private_ips = [cidrhost(aws_subnet.sandbox_private_subnet_13.cidr_block, local.subnet_13_ips[count.index])]

  ipv6_addresses = [cidrhost(aws_subnet.sandbox_private_subnet_13.ipv6_cidr_block, local.subnet_13_ips[count.index])]
  // Same effect as above
  // ipv6_address_list_enabled = true
  // ipv6_address_list = [cidrhost(aws_subnet.sandbox_private_subnet_13.ipv6_cidr_block, local.subnet_13_ips[count.index])]

  // Instances cannot act as routers without this
  // https://docs.aws.amazon.com/vpc/latest/userguide/VPC_NAT_Instance.html#EIP_Disable_SrcDestCheck
  source_dest_check = false

  tags = merge(
    {
      internal = true
    },
    var.resource_tags
  )
}

resource "aws_network_interface_attachment" "private_subnet_13_attachment_1" {
  instance_id          = "${aws_instance.router[0].id}"
  network_interface_id = aws_network_interface.private_subnet_13[0].id

  // IP addresses per network interface per instance type
  // https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-eni.html#AvailableIpPerENI
  device_index         = 2
}

resource "aws_network_interface_attachment" "private_subnet_13_attachment_3" {
  instance_id          = "${aws_instance.router[2].id}"
  network_interface_id = aws_network_interface.private_subnet_13[1].id

  // IP addresses per network interface per instance type
  // https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-eni.html#AvailableIpPerENI
  device_index         = 1
}
