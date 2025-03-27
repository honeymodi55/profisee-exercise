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
    ingress {
        description = "Jenkins"
        from_port = "8080"
        to_port = "8080"
        protocol = "tcp"
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    }
    ingress {
        description = "https"
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        cidr_blocks = [
            "0.0.0.0/0"
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
    
    connection {
      type = "ssh"
      user = "ec2-user"
      host = self.public_ip
    }
   
    provisioner "remote-exec" {
        inline = [ 
            "sudo yum update -y",
            "sudo yum install -y docker",
            "sudo systemctl start docker",
            "sudo systemctl enable docker",
            "sudo usermod -aG docker ec2-user",
            "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
            "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key",
            "sudo yum upgrade",
            "sudo dnf install java-17-amazon-corretto -y",
            "sudo yum install jenkins -y",
            "sudo systemctl enable jenkins",
            "sudo systemctl start jenkins"
         ]
    }

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
