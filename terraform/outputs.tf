// Type "terraform output" to see the output

output "instance_dns_names" {
  value = {
    for inst in aws_instance.router:
      inst.tags.Name => inst.public_dns
  }
}

output "instance_public_ips" {
  value = {
    for inst in aws_instance.router:
      inst.tags.Name => inst.public_ip
  }
}

output "CIDR_blocks" {
  value = {
    "router1_to_router2" = {
      "ipv4" = aws_subnet.sandbox_private_subnet_12.cidr_block
      "ipv6" = aws_subnet.sandbox_private_subnet_12.ipv6_cidr_block
    }
    "router1_to_router3" = {
      "ipv4" = aws_subnet.sandbox_private_subnet_13.cidr_block
      "ipv6" = aws_subnet.sandbox_private_subnet_13.ipv6_cidr_block
    }
    "router2_to_router3" = {
      "ipv4" = aws_subnet.sandbox_private_subnet_23.cidr_block
      "ipv6" = aws_subnet.sandbox_private_subnet_23.ipv6_cidr_block
    }
  }
}

// Ansible inventory in yaml format
resource "local_file" "routers_yml" {
    content     = replace(
    yamlencode(
      tomap({
        "all" = tomap({
          "hosts" = tomap({
            for inst in aws_instance.router:
            inst.public_dns => tomap({
              "router_index" = inst.tags.vm_index
              "hostname" = inst.tags.Name
              "public_ip" = inst.public_ip
            })
          })
        })
      })
    ),
    "\"", "")
    filename = "${path.module}/routers.yml"
}

// Ansible inventory in ini format. All hosts are in "ungrouped" default group
resource "local_file" "routers" {
    content     = join("\n",
      [for inst in aws_instance.router:
        inst.public_dns]
    )
    filename = "routers"
}
