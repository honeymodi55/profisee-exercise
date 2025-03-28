## printing the output ids on terminal ##
output "security_group" {
    value = aws_security_group.profiseeDemoEC2-sg.id
}
output "ec2_instance" {
    value = aws_instance.profiseeDemoEC2.id
}

########## showing the output on terminal ##########
output "vpc_id" {
  value = aws_vpc.profiseeVPC.id
}
output "public_subnet_id" {
  value = aws_subnet.publicSubnet.id
}
output "private_subnet_id" {
  value = aws_subnet.privateSubnet.id
}