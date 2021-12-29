variable "account_id" {
    type = map(string)
}

variable "aws_access_key_id" {
}

variable "aws_secret_access_key" {
}

variable "aws_session_token" {
}

variable "region" {
}

variable "env" {
}

variable "hz_name" {
}

variable "vpc_azs" { 
    type = list(string)
}

variable "vpc_private_sn" {
    type = list(string)
}

variable "vpc_octet2" {
}
