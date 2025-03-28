## Security Group for RDS##

resource "aws_security_group" "profiseeRDS-sg" {
    name = "profisee-rds-sg"
    description = "PostgreSQL security group"
    vpc_id = aws_vpc.profiseeVPC.id
    tags = {
      Name = "profisee"
    }

    ingress {
        description = "PostgreSQL access from within VPC"
        from_port = "5432"
        to_port = "5432"
        protocol = "tcp"
        cidr_blocks = [
            "10.224.0.0/16"
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

output "rds_sg_id" {
  value = aws_security_group.profiseeRDS-sg.id
}