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
output "vpc_cidr_blocks" {
  value = aws_vpc.profiseeVPC.cidr_block
}
output "public_subnet_ids" {
  value = [ aws_subnet.publicSubnetA.id , aws_subnet.publicSubnetB.id ]
}
output "private_subnet_ids" {
  value = [ aws_subnet.privateSubnetA.id, aws_subnet.privateSubnetB.id ]
}