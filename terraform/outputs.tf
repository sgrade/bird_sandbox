// Type "terraform output" to see the output

output "instance_dns_names" {
  value = tomap({
    for inst in aws_instance.router:
      inst.tags.Name => inst.public_dns
  })
}

output "instance_public_ips" {
  value = tomap({
    for inst in aws_instance.router:
      inst.tags.Name => inst.public_ip
  })
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
