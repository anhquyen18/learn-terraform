provider "aws"{}

variable "cidr_blocks" {
  type        = list(object({
    cidr_block = string
    name = string
  }))
  description = "subnet and vpc cider block, name"
#   default = "10.0.1.0/24"
}

resource "aws_vpc" "development-vpc"{
    cidr_block = var.cidr_blocks[0].cidr_block
    tags = {
        Name: var.cidr_blocks[0].name
    }
}

resource "aws_subnet" "dev-subnet-1"{
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = var.cidr_blocks[1].cidr_block
    availability_zone = "ap-southeast-1a"
    tags = {
        Name: var.cidr_blocks[1].name
    }
}

# data "aws_vpc" "existing_vpc"{
#     default = true
# }

# resource "aws_subnet" "dev-subnet-2"{
#     vpc_id = data.aws_vpc.existing_vpc.id
#     cidr_block = "172.31.48.0/24"
#     availability_zone = "ap-southeast-1a"
#     tags = {
#         Name: "subnet-1-default"
#     }
# }

output "dev-vpc-id" {
  value       = aws_vpc.development-vpc.id
}

output "dev-subnet-id" {
  value       = aws_subnet.dev-subnet-1.id
}
