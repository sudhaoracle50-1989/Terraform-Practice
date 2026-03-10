variable "ami_id"{ 
    description = "passing values to ami-id"  
    default = "ami-03caad32a158f72db" 
    type = string
}       

variable "instance_type" {
    default = "t2.micro"    
    type = string
    
}
