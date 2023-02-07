resource "aws_cognito_user_pool" "pool" {
  name = "overwatch"
  admin_create_user_config {
    allow_admin_create_user_only = true
  }
  username_attributes = ["email"]

}


resource "aws_cognito_user_pool_client" "client" {
  name = "cognito-client"

  user_pool_id                  = aws_cognito_user_pool.pool.id
  generate_secret               = false
  refresh_token_validity        = 90
  prevent_user_existence_errors = "ENABLED"
  explicit_auth_flows = [
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH"
  ]
  callback_urls                        = ["https://example.com"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["implicit"]
  allowed_oauth_scopes                 = ["email", "openid"]
  supported_identity_providers         = ["COGNITO"]
}

resource "aws_cognito_user_pool_domain" "cognito-domain" {
  domain       = "overwatch-auth"
  user_pool_id = aws_cognito_user_pool.pool.id
}