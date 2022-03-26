resource "aws_api_gateway_method" "noncompliantapi" {
  authorization = "NONE"
  http_method   = "GET"
}

resource "aws_iam_policy" "lambdaUpdatePolicy" {
  name = "lambdaUpdatePolicy"
  policy =<<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "lambda:UpdateFunctionCode"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "azurerm_data_lake_store" "store" {
  name             = "store"
  encryption_state = "Disabled"
}

resource "aws_security_group" "noncompliant" {
  name        = "allow_ssh_noncompliant"
  description = "allow_ssh_noncompliant"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "SSH rule"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "mynoncompliantbucket" {
  bucket = "mybucketname"

  tags = {
    "anycompany:cost-center" = "Accounting"
  }
}
