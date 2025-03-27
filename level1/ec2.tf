########## to create security groups and ec2 instance ##########

## Security Groups ##
resource "aws_security_group" "profiseeDemoEC2-sg" {
    name = "profisee-demoEC2-sg"
    vpc_id = aws_vpc.profiseeVPC.id
    tags = {
      Name = "profisee-demoEC2-sg"
    }

    ingress {
        description = "SSH"
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_blocks = [
            "50.220.104.154/32"
        ]
    }
    egress {
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    }
}

## EC2 instance ##
resource "aws_instance" "profiseeDemoEC2" {
    ami = "ami-0f9d441b5d66d5f31"
    instance_type = "t2.large"
    key_name = "cicd-pipeline-key"
    subnet_id = aws_subnet.publicSubnet.id
    vpc_security_group_ids = [aws_security_group.profiseeDemoEC2-sg.id]
    associate_public_ip_address = true
    
    /*provisioner "local-exec" {
      command = "scp -o StrictHostKeyChecking=no -i \"/Users/honeymodi/Desktop/VS_proj_prac/cicd-pipeline-creds&keys/newones/cicd-pipeline-key.pem\" jenkins-docker-install.sh ec2-user@${self.public_ip}:/home/ec2-user/"
    }
    provisioner "local-exec" {
      command = "ssh -o StrictHostKeyChecking=no -i \"/Users/honeymodi/Desktop/VS_proj_prac/cicd-pipeline-creds&keys/newones/cicd-pipeline-key.pem\" ec2-user@${self.public_ip} 'bash /home/ec2-user/jenkins-docker-install.sh'"
    }*/

    tags = {
      Name = "profisee-demo-ec2"
    }
}

## printing the output ids on terminal ##
output "security_group" {
    value = aws_security_group.profiseeDemoEC2-sg.id
}
output "ec2_instance" {
    value = aws_instance.profiseeDemoEC2.id
}