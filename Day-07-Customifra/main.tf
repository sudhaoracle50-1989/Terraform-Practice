#vpc creation with public and private subnets, IGW, route table, security group and EC2 instance in public subnet
resource "aws_vpc" "Dev" {

  cidr_block = "10.0.0.0/16"
    tags = {
        Name = "Dev003"
    }
}

#creating public and private subnets in the VPC
resource "aws_subnet" "Public" {
    vpc_id = aws_vpc.Dev.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-west-2a"
    tags = {
        Name = "Public"
    }
}

resource "aws_subnet" "Private" {
    vpc_id = aws_vpc.Dev.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-west-2b"
    tags = {
        Name = "Private"
    }
}

#creating IGW and attaching it to the VPC
resource "aws_internet_gateway" "DEV-IGW" {
    vpc_id = aws_vpc.Dev.id
    tags = {
        Name = "DEV-IGW"
    }
  
}
#creating route table and associating it with public subnet
resource "aws_route_table" "Public-RT-Dev" {
    vpc_id = aws_vpc.Dev.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.DEV-IGW.id
    }
}

resource "aws_route_table_association" "Public-RT-Dev" {
    subnet_id = aws_subnet.Public.id
    route_table_id = aws_route_table.Public-RT-Dev.id
}

#creating security group and allowing inbound traffic on port 22 and 80
resource "aws_security_group" "Dev-SG" {
    name = "Dev-SG"
    description = "allows inbound traffic on port 22 and 80"
    vpc_id = aws_vpc.Dev.id

    ingress {
        from_port = 22
        to_port = 22    
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
  
}
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
#creating EC2 instance in public subnet and associating it with the security group
resource "aws_instance" "Dev-EC2" {
    ami = "ami-0d76b909de1a0595d"
    instance_type = "t3.small"
    subnet_id = aws_subnet.Public.id
    vpc_security_group_ids = [aws_security_group.Dev-SG.id]
    tags = {
        Name = "Dev-EC2-instance"
    }   
}
