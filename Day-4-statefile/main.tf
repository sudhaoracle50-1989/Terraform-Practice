resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "test"
    }
  
}

resource "aws_instance" "name" {
    ami = "ami-0d76b909de1a0595d"
    instance_type = "t3.small"
    iam_instance_profile = "SR002"
    tags = {
        Name = "test001-instance"
    }   
  
}