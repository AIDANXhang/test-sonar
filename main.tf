resource "aws_api_gateway_method" "compliantapi" {
  authorization = "AWS_IAM"
  http_method   = "GET"
}
