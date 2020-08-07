provider "aws" {
    region = "eu-west-2"
}

resource "aws_iam_user" "buddhaform" {
    name = "buddhaform"
}

resource "aws_iam_policy" "glacier_policy" {
    name = "glacier_policy"
    policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "VisualEditor0",
          "Effect": "Allow",
          "Action": "glacier:*",
          "Resource": "*"
        }
      ]
}
    EOF
}

resource "aws_iam_policy_attachment" "buddhamagnet_attachment" {
  name = "buddhamagnet_attachment"
  policy_arn = aws_iam_policy.glacier_policy.arn
  users = [aws_iam_user.buddhaform.name]
}
