variable "region"          { default = "us-east-1" }
variable "environment"     { default = "dev" }

variable "pgadmin_username" { description = "Postgres admin username" }
variable "pgadmin_password" {
  description = "Postgres admin password"
  sensitive   = true
}