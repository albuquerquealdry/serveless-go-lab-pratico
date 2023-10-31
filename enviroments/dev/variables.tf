variable "api_core" {
  default = "users"
  description = "Path da API a ser Desenvolvida"
}

variable "aws_region" {
  default = "us-east-1"
  description = "Região da AWS por Ambiente"
}

variable "enviroment" {
  default = "dev"
  description = "Ambiente da aplicação"
}

variable "project" {
  default = "bank"
  description = "Ambiente da aplicação"
}


variable "tags" {
  default = {
    BU            =  "BU NAME"
    Environment   =  "dev"
    Name          =  "bank-serveless-app"
    Department    =  "DEPARTAMENT"
    Owner         =  "OWNER PROJECT"
    Workload      =  "WORKLOAD"
  }
}