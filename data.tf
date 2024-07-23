# Fetch the latest Amazon Linux 3 AMI (ec2 image) with a given pattern
data "aws_ami" "amazon_linux_3" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-amazon-linux-3.*-x86_64-gp2"]
  }
  owners = ["amazon"]
}

# Fetch the AWS account ID
data "aws_caller_identity" "current" {}
