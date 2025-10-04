# Assume Role Policy for EC2
data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# IAM Role
resource "aws_iam_role" "ec2_role" {
  name               = "${var.project_name}-${var.environment}-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
  description        = "IAM role for EC2 instances in ${var.project_name} project"

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role_policy_attachment" "s3_read_only" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = var.attach_s3_read_only ? "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess" : null
  depends_on = [aws_iam_role.ec2_role]
}

