data "aws_iam_policy_document" "role_policy_dynamodb_bank_create" {
  statement {
    sid = "1"

    actions = [
        "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "policy_dynamodb_lambda_bank_create" {

  statement {
    sid = "SidToOverride"

    actions = ["dynamodb:PutItem"]

    resources = [
        "${module.dynamodb_table_bank.arn}"
    ]
  }
}