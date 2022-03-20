// Files with BGP Peers configuration - used in Ansible

resource "local_file" "router1_bgp_peers_yml" {
    content = yamlencode(
      tomap({
        "bgp_peers_ipv4" = tolist([
          tomap({
            name: "router2"
            type: "external"
            local_ip_address: one(aws_network_interface.private_subnet_12[0].private_ips)
            peer_ip_address: one(aws_network_interface.private_subnet_12[1].private_ips)
            asn: 64522
            max_prefix: "off"
          }),
          tomap({
            name: "router3"
            type: "external"
            local_ip_address: one(aws_network_interface.private_subnet_13[0].private_ips)
            peer_ip_address: one(aws_network_interface.private_subnet_13[1].private_ips)
            asn: 64523
            max_prefix: "off"
          })
        ])
        "bgp_peers_ipv6" = tolist([
          tomap({
            name: "router2"
            type: "external"
            local_ip_address: one(aws_network_interface.private_subnet_12[0].ipv6_addresses)
            peer_ip_address: one(aws_network_interface.private_subnet_12[1].ipv6_addresses)
            asn: 64522
            max_prefix: "off"
          }),
          tomap({
            name: "router3"
            type: "external"
            local_ip_address: one(aws_network_interface.private_subnet_13[0].ipv6_addresses)
            peer_ip_address: one(aws_network_interface.private_subnet_13[1].ipv6_addresses)
            asn: 64523
            max_prefix: "off"
          })
        ])
      })
    )
    filename = "${path.module}/router1_bgp_peers.yml"
}

resource "local_file" "router2_bgp_peers_yml" {
    content = yamlencode(
      tomap({
        "bgp_peers_ipv4" = tolist([
          tomap({
            name: "router1"
            type: "external"
            local_ip_address: one(aws_network_interface.private_subnet_12[1].private_ips)
            peer_ip_address: one(aws_network_interface.private_subnet_12[0].private_ips)
            asn: 64521
            max_prefix: "off"
          }),
          tomap({
            name: "router3"
            type: "external"
            local_ip_address: one(aws_network_interface.private_subnet_23[0].private_ips)
            peer_ip_address: one(aws_network_interface.private_subnet_23[1].private_ips)
            asn: 64523
            max_prefix: "off"
          })
        ])
        
        "bgp_peers_ipv6" = tolist([
          tomap({
            name: "router1"
            type: "external"
            local_ip_address: one(aws_network_interface.private_subnet_12[1].ipv6_addresses)
            peer_ip_address: one(aws_network_interface.private_subnet_12[0].ipv6_addresses)
            asn: 64521
            max_prefix: "off"
          }),
          tomap({
            name: "router3"
            type: "external"
            local_ip_address: one(aws_network_interface.private_subnet_23[0].ipv6_addresses)
            peer_ip_address: one(aws_network_interface.private_subnet_23[1].ipv6_addresses)
            asn: 64523
            max_prefix: "off"
          })
        ])
      })
    )
    filename = "${path.module}/router2_bgp_peers.yml"
}

resource "local_file" "router3_bgp_peers_yml" {
    content = yamlencode(
      tomap({
        "bgp_peers_ipv4" = tolist([
          tomap({
            name: "router1"
            type: "external"
            local_ip_address: one(aws_network_interface.private_subnet_13[1].private_ips)
            peer_ip_address: one(aws_network_interface.private_subnet_13[0].private_ips)
            asn: 64521
            max_prefix: "off"
          }),
          tomap({
            name: "router2"
            type: "external"
            local_ip_address: one(aws_network_interface.private_subnet_23[1].private_ips)
            peer_ip_address: one(aws_network_interface.private_subnet_23[0].private_ips)
            asn: 64522
            max_prefix: "off"
          })
        ])
        
        "bgp_peers_ipv6" = tolist([
          tomap({
            name: "router1"
            type: "external"
            local_ip_address: one(aws_network_interface.private_subnet_13[1].ipv6_addresses)
            peer_ip_address: one(aws_network_interface.private_subnet_13[0].ipv6_addresses)
            asn: 64521
            max_prefix: "off"
          }),
          tomap({
            name: "router2"
            type: "external"
            local_ip_address: one(aws_network_interface.private_subnet_23[1].ipv6_addresses)
            peer_ip_address: one(aws_network_interface.private_subnet_23[0].ipv6_addresses)
            asn: 64522
            max_prefix: "off"
          })
        ])
      })
    )
    filename = "${path.module}/router3_bgp_peers.yml"
}
