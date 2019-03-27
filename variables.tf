// GCP Variables

variable "gcp_ip_cidr_range" {
  default     = "10.0.1.0/24"
  type        = "string"
  description = "IP CIDR for Google VPC"
}

// AWS Variables
variable "aws_ip_cidr_range" {
  default     = "10.0.0.0/16"
  type        = "string"
  description = "IP CIDR for AWS VPC"
}

// Subnets information

variable "subnet_names" {
  type = "map"

  default = {
    subnet1 = "subnetone"
    subnet2 = "subnettwo"
    subnet3 = "subnetthree"
  }
}
