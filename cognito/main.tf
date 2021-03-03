resource "aws_cognito_user_pool" "main" {
  name = "${var.aws_cognito_user_pool_name}"
  auto_verified_attributes = ["email"]
  mfa_configuration = "OFF"
  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }
  username_configuration {
    case_sensitive = true
  }
  schema {
    attribute_data_type = "String"
    name = "email"
    required = true
  }
}

resource "aws_cognito_user_pool_client" "main" {
  name = "${var.aws_cognito_user_pool_client_name}"
  user_pool_id = aws_cognito_user_pool.user_pool.id
  explicit_auth_flows = [
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH"
  ]
  allowed_oauth_flows_user_pool_client = false
  generate_secret = false
  prevent_user_existence_errors = "ENABLED"
}


resource "aws_iam_role" "main" {
  name = "${var.aws_iam_role_name}"
  tags = {
    "role_tag" = "office_role_tag"
  }
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1614748446378",
      "Action": [
        "sts:AssumeRoleWithWebIdentity"
      ],
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:sub": "demoofficesubject1234"
        }
      }
    }
  ]
}
  EOF
}

resource "aws_cognito_user_group" "main" {
  name = "${var.aws_cognito_user_group_name}"
  user_pool_id = aws_cognito_user_pool.user_pool.id
  role_arn = aws_iam_role.group_role.arn
}