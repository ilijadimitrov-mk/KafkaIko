# Create an IAM role
resource "aws_iam_role" "EC2_Default_IAM_Role1" {
  name = "EC2_Default_IAM_Role1"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach the IAM policy to the IAM role
resource "aws_iam_role_policy_attachment" "IAMSysOpsMSKPolicy_attachment" {
  policy_arn = aws_iam_policy.IAMSysOpsMSKPolicy.arn
  role       = aws_iam_role.EC2_Default_IAM_Role1.name
}

resource "aws_iam_role_policy_attachment" "AWSBackupFullAccess_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AWSBackupFullAccess"
  role       = aws_iam_role.EC2_Default_IAM_Role1.name
}


resource "aws_iam_role_policy_attachment" "AmazonS3FullAccess_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.EC2_Default_IAM_Role1.name
}


resource "aws_iam_role_policy_attachment" "CloudWatchAgentAdminPolicy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentAdminPolicy"
  role       = aws_iam_role.EC2_Default_IAM_Role1.name
}

resource "aws_iam_role_policy_attachment" "CloudWatchAgentServerPolicy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.EC2_Default_IAM_Role1.name
}

resource "aws_iam_role_policy_attachment" "AWSBackupServiceRolePolicyForBackup_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.EC2_Default_IAM_Role1.name
}

resource "aws_iam_role_policy_attachment" "AWSBackupServiceRolePolicyForRestores_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
  role       = aws_iam_role.EC2_Default_IAM_Role1.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2RoleforSSM_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  role       = aws_iam_role.EC2_Default_IAM_Role1.name
}

resource "aws_iam_role_policy_attachment" "AmazonSSMMaintenanceWindowRole_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonSSMMaintenanceWindowRole"
  role       = aws_iam_role.EC2_Default_IAM_Role1.name
}


# Create an IAM instance profile
resource "aws_iam_instance_profile" "EC2_Default_IAM_Role1" {
  name = "EC2_Default_IAM_Role1"
  role = aws_iam_role.EC2_Default_IAM_Role1.name
}

