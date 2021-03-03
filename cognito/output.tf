output "user_pool_id" {
  description = "Id of user pool"
  value = "${aws_cognito_user_pool.user_pool.id}"
}

output "user_pool_client_id" {
  description = "Id of user pool client"
  value = "${aws_cognito_user_pool_client.user_pool.id}"
}