output "public_ip1" {
    description = "ec2 instance public ip"
    value = aws_instance.my_ec2_instance1.public_ip

}

output "public_ip2" {
    description = "ec2 instance public ip"
    value = aws_instance.my_ec2_instance2.public_ip

}
output "vpc_id" {
    description = "vpc id"
    value = aws_vpc.my_first_vpc.id     
}

output "igw" {
  description = "Internet gateway output"
 value       = aws_internet_gateway.my_igw.id
}

output "security_group" {
  description = "security group id"
  value = aws_security_group.allow_ssh.id
}