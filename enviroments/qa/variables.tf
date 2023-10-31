variable "api_core" {
  default = "api_core"
  description = "Path da API a ser Desenvolvida"
}

variable "aws_region" {
  default = "us-east-1"
  description = "Região da AWS por Ambiente"
}

variable "enviroment" {
  default = "qa"
  description = "Ambiente da aplicação"
}

variable "tags" {
  default = {
    BU            = "BU NAME"
    Environment   =  var.enviroment
    Name          =  "${var.api_core}-serveless-app"
    Department    = "DEPARTAMENT"
    Owner         = "OWNER PROJECT"
    Workload      = "WORKLOAD"
  }
}