resource "aws_security_group" "name" {
    name        = "EC2-SG"
    description = "Security group for multiple rules with same source CIDR"
   
    
#     ingress {
#         from_port   = 80
#         to_port     = 80
#         protocol    = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }
# }

# ingress {
#     description = "Allow HTTPS traffic from the same source CIDR"
#         from_port   = 443
#         to_port     = 443
#         protocol    = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }

#     ingress {
#         description = "Allow SSH traffic from the same source CIDR"
#         from_port   = 22
#         to_port     = 22
#         protocol    = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }


ingress = [
    for port in [80, 443, 22 , 3000, 9000, 8082, 8081] : {
        description = "inboundrules"
        from_port   = port
        to_port     = port
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
    }
]

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"] 
    }

tags   = {
    Name = "sudhakar-EC2-SG"
}   
}