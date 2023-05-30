variable "name" {
  type = string
}

variable "region" {
  type = string
}

variable "db_tier" {
  type    = string
  default = "db-f1-micro"
}

variable "vpc_name" {
  type    = string
  default = "default"
}
