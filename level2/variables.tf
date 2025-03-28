variable "vpc_id" {
  type = string
  description = "value of vpc id from level1"
}

variable "private_subnet_id" {
  type = string
  description = "value of private subnet id from level1"
}

variable "public_subnet_id" {
  type = string
  description = "value of public subnet id from level1"
}

variable "security_group" {
  type = string
  description = "value of sg from level1"
}