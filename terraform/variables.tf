// Variables

variable "region" {
  default = "eu-central-1"
}

variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default     = {
    project     = "default",
    environment = "sandbox",
    terraform   = "true"
  }
}

variable "ec2_instance_type" {
  description = "AWS EC2 instance type."
  type        = string
  // IP addresses per network interface per instance type
  // https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-eni.html#AvailableIpPerENI
  // micro and nano don't have enough interfaces for the setup with public network on each instance and two private networks
  // default     = "t2.micro"
  default     = "t2.small"
}

variable "instance_count" {
  description = "Number of instances to provision."
  type        = number
  default     = 3
}

// New VPC, creaded by this automation
variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string

  // 10.0.0-9    - for public sunets
  // 10.0.10-254 - for private subnets
  default     = "10.0.0.0/16"
}

variable "enable_vpn_gateway" {
  description = "Enable a VPN gateway in your VPC."
  type        = bool
  default     = false
}

variable "key_name" {
  description = "The key name of the Key Pair to use for the instance"
  type        = string
  default     = "default-key"
}
