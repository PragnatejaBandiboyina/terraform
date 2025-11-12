# Create IAM User
resource "aws_iam_user" "user-IAM" {
  name = "my-iam-user"
  path = "/"
}

# Attach AWS Managed Policy to IAM User
resource "aws_iam_user_policy_attachment" "managed_policy_attach" {
  user       = aws_iam_user.user-IAM.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

#  Inline Custom Policy for S3 Bucket Access (specific bucket)
resource "aws_iam_user_policy" "inline_s3_policy" {
  name = "S3BucketAccessPolicy"
  user = aws_iam_user.user-IAM.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "S3BucketAccess"
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "arn:aws:s3:::pragnatejajahnavibandiboyina",
          "arn:aws:s3:::pragnatejajahnavibandiboyina/*"
        ]
      }
    ]
  })
}
# Create IAM Access Key for the User
resource "aws_iam_access_key" "user_key" {
  user = aws_iam_user.user-IAM.name
}

#  Output Access Key & Secret 
output "access_key_id" {
  value = aws_iam_access_key.user_key.id
}

output "secret_access_key" {
  value     = aws_iam_access_key.user_key.secret
  sensitive = true
}

#secret_access_key (hidden by default — type terraform output secret_access_key to reveal it)

