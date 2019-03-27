### Google Infrastructure
# Creates a new VPC in GCP.
resource "google_compute_network" "vpc-test-2" {
  name                    = "devnetwork"
  auto_create_subnetworks = false
}

# Add subnet to Google Network
resource "google_compute_subnetwork" "dev-subnet" {
  ip_cidr_range = "10.0.1.0/24"
  name          = "devsubnet"
  network       = "${google_compute_network.vpc-test-2.self_link}"
  region        = "us-west1"
}

### AWS Infrastructure
# Creates a new VPC in AWS.
resource "aws_vpc" "environment-example-two" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "terraform-aws-vpc"
  }
}

# Creates subnets in AWS vpc
resource "aws_subnet" "subnet1" {
  cidr_block        = "${cidrsubnet(aws_vpc.environment-example-two.cidr_block, 3, 1)}"
  vpc_id            = "${aws_vpc.environment-example-two.id}"
  availability_zone = "us-east-1a"

  tags {
    Name = "terraform-subnet1"
  }
}

resource "aws_subnet" "subnet2" {
  cidr_block        = "${cidrsubnet(aws_vpc.environment-example-two.cidr_block, 2, 2)}"
  availability_zone = "us-east-1b"
  vpc_id            = "${aws_vpc.environment-example-two.id}"

  tags {
    Name = "terraform-subnet2"
  }
}

# Adds Security Group for the VPC
resource "aws_security_group" "aws-security" {
  vpc_id = "${aws_vpc.environment-example-two.id}"

  tags {
    Name = "tf-aws-sg1"
  }

  ingress {
    cidr_blocks = [
      "${aws_vpc.environment-example-two.cidr_block}",
    ]

    from_port = 80
    protocol  = "tcp"
    to_port   = 80
  }
}
