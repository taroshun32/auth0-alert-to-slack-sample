resource "auth0_log_stream" "event_bridge" {
  name   = "Amazon EventBridge"
  type   = "eventbridge"
  status = "active"

  filters = [
    {
      "name" = "auth.login.fail"
      "type" = "category"
    },
    {
      "name" = "auth.logout.fail"
      "type" = "category"
    },
    {
      "name" = "auth.signup.fail"
      "type" = "category"
    },
    {
      "name" = "auth.silent_auth.fail"
      "type" = "category"
    },
    {
      "name" = "auth.token_exchange.fail"
      "type" = "category"
    },
    {
      "name" = "management.fail"
      "type" = "category"
    },
    {
      "name" = "user.fail"
      "type" = "category"
    }
  ]

  sink {
    aws_account_id = var.aws_account_id
    aws_region     = "ap-northeast-1"
  }
}
