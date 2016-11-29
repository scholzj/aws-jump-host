##########################
# IAM: Policies and Roles
##########################

# The following Roles and Policy are mostly for future use

resource "aws_iam_role" "jumphost_iam" {
  name = "${var.vpc_name}-jumphost"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Role policy
resource "aws_iam_role_policy" "jumphost_policy" {
  name = "${var.vpc_name}-jumphost"
  role = "${aws_iam_role.jumphost_iam.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action" : ["ec2:*"],
      "Effect": "Allow",
      "Resource": ["*"]
    },
    {
      "Effect":"Allow",
      "Action":[
        "s3:GetObject"
      ],
      "Resource":"arn:aws:s3:::${var.vpc_name}-jumphost-bootstrap/*"
    }
  ]
}
EOF

  depends_on = [
    "aws_s3_bucket.jumphost-bootstrap"
  ]
}

# IAM Instance Profile for Controller
resource  "aws_iam_instance_profile" "jumphost_profile" {
 name = "${var.vpc_name}-jumphost"
 roles = ["${aws_iam_role.jumphost_iam.name}"]
}
