resource "aws_cloudwatch_event_bus" "auth0_error_log" {
  name              = var.auth0_event_name
  event_source_name = var.auth0_event_name
}

resource "aws_cloudwatch_event_rule" "auth0_error_log" {
  name           = "auth0-error-log"
  event_bus_name = aws_cloudwatch_event_bus.auth0_error_log.name

  event_pattern = <<EOF
{
  "account": ["${var.aws_account_id}"],
  "detail": {
    "data": {
      "type": [ { "anything-but": [
        "fp",
        "fu"
      ] } ]
    }
  }
}
EOF
}

data "aws_lambda_function" "auth0_alert_to_slack" {
  function_name = "auth0-alert-to-slack-dev-notify"
}

resource "aws_lambda_permission" "allow_auth0_alert_to_slack" {
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_function.auth0_alert_to_slack.arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.auth0_error_log.arn
}

resource "aws_cloudwatch_event_target" "auth0_error_log" {
  rule           = aws_cloudwatch_event_rule.auth0_error_log.name
  event_bus_name = aws_cloudwatch_event_bus.auth0_error_log.name
  target_id      = "auth0-error-log"
  arn            = data.aws_lambda_function.auth0_alert_to_slack.arn
}
