module "dynamodb_table_bank" {
  source         = "../../base_resources/modules/dynamo-sem-gsi"
  name           = "${var.api_core}-${var.project}-bank-table"
  hash_key       =  "id"
  write_capacity = 1
  read_capacity  = 1
  pk_name        = "id"
  pk_type        = "S"
  tags           = var.tags
}

module "parameter-ssm-table_name_booking" {
  source         = "../../base_resources/modules/ssm"
  name           = "${var.enviroment}-parameter-${var.api_core}-${var.project}-bank-table-table_name"
  type           = "String"     
  value          =  module.dynamodb_table_bank.table_name
  tags           = var.tags
}