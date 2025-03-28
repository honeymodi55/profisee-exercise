## printing the output ids on terminal ##
output "security_group_id" {
    value = aws_security_group.profiseeDemoEC2-sg.id
}
output "ec2_instance_id" {
    value = aws_instance.profiseeDemoEC2.id
}

########## showing the output on terminal ##########
output "vpc_id" {
  value = aws_vpc.profiseeVPC.id
}
output "public_subnet_ids" {
  value = [ aws_subnet.publicSubnet.id, aws_subnet.publicSubnet.id ]
}
output "private_subnet_ids" {
  value = [ aws_subnet.privateSubnet.id, aws_subnet.privateSubnet.id ]
}