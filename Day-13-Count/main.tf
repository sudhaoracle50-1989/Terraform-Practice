variable "ami_id" {
  description = "passing values to ami-id"
  type        = string
}

variable "instance_type" {
  type = string
}

# resource "aws_instance" "name" {
#   ami           = var.ami_id
#   instance_type = var.instance_type

#   count = 3
#   tags = {
#     Name = "UAT-EC2-instance-${count.index}"
#   }
# }

variable "env" {
  description = "Environment name (dev, staging, prod)"
  type        = list(string)

  default = ["dev", "prod"]  # it is modified code and earlier 3 have 3 but for removing purpose removed staging 
}

resource "aws_instance" "name" {
  ami           = var.ami_id
  instance_type = var.instance_type

  count = length(var.env)

  tags = {
    Name = "${var.env[count.index]}-EC2-instance"
  }
}
