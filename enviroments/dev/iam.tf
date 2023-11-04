module "bank_create_role" {
    source         = "../../base_resources/modules/iam-assume-role"
    name           = "${var.api_core}-${var.project}-bank-"
    tags           = var.tags
    policy_data    = data.aws_iam_policy_document.role_policy_dynamodb_bank_create.json
}

module "bank_create_policy" {
    source         = "../../base_resources/modules/iam-policy"
    name           = "${var.api_core}-${var.project}-bank-"
    policy         =  data.aws_iam_policy_document.policy_dynamodb_lambda_bank_create.json
    tags           = var.tags
}

module "bank_create_policy_attachement" {
    source         = "../../base_resources/modules/iam-policy-attachement"
    role_name      = module.bank_create_role.name
    policy_arn     = module.bank_create_policy.arn

}

module "bank_create_policy_attachement_policy_basic_bank_create" {
    source         = "../../base_resources/modules/iam-policy-attachement"
    role_name      = module.bank_create_role.name
    policy_arn     = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"

}

module "parameter-ssm-register-role-arn" {
  source         = "../../base_resources/modules/ssm"
  name           = "${var.enviroment}-parameter-${var.api_core}-${var.project}-role-arn"
  type           = "String"     
  value          =  module.bank_create_role.arn
tags             = var.tags
}

################# MODERATOR

module "moderator_role" {
    source         = "../../base_resources/modules/iam-assume-role"
    name           = "${var.api_core}-${var.project}-bank-moderator"
    tags           = var.tags
    policy_data    = data.aws_iam_policy_document.role_policy_dynamodb_bank_create.json
}

module "moderator_policy" {
    source         = "../../base_resources/modules/iam-policy"
    name           = "${var.api_core}-${var.project}-bank-moderator"
    policy         =  data.aws_iam_policy_document.policy_dynamodb_lambda_bank_moderator_update.json
    tags           = var.tags
}

module "moderator_policy_attachement" {
    source         = "../../base_resources/modules/iam-policy-attachement"
    role_name      = module.moderator_role.name
    policy_arn     = module.moderator_policy.arn

}

module "moderator_policy_attachement_policy_basic" {
    source         = "../../base_resources/modules/iam-policy-attachement"
    role_name      = module.moderator_role.name
    policy_arn     = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"

}

module "parameter-ssm-moderator-role-arn" {
  source         = "../../base_resources/modules/ssm"
  name           = "${var.enviroment}-parameter-${var.api_core}-${var.project}-moderator-role-arn"
  type           = "String"     
  value          =  module.moderator_role.arn
tags             = var.tags
}