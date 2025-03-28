resource "aws_db_subnet_group" "rdsSubnetGroup" {
  name = "rds-subnet-group-private"
  subnet_ids = [ aws_subnet.privateSubnetA.id, aws_subnet.privateSubnetB.id ]

  tags = {
    Name = "profisee"
  }
}

resource "aws_db_parameter_group" "rdsParamGroup" {
  name = "rds-param-group"
  family = "postgres17"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}


resource "aws_db_instance" "profiseeRDS" {
  db_name = "postgres"
  identifier = "profisee-rds"
  instance_class = "db.t3.small"
  allocated_storage = 10
  engine = "postgres"
  engine_version = "17.2"
  username = var.db_username
  password = var.db_password
  db_subnet_group_name = aws_db_subnet_group.rdsSubnetGroup.name
  vpc_security_group_ids = [aws_security_group.profiseeRDS-sg.id]
  parameter_group_name = aws_db_parameter_group.rdsParamGroup.name
  publicly_accessible = false
  skip_final_snapshot = true
}

## OUTPUTS 
output "rds_endpoint" {
  value = aws_db_instance.profiseeRDS.address
}




