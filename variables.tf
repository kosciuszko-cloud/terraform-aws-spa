variable "account_id" {
    type = map(string)
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
