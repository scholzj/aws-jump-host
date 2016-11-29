
#########################
# Jump host instance
#########################

resource "aws_launch_configuration" "jump_conf" {
    name_prefix = "${var.vpc_name}-jumphost-"
    image_id = "${var.default_ami}"
    instance_type = "${var.jump_host_type}"

    associate_public_ip_address = true

    iam_instance_profile = "${aws_iam_instance_profile.jumphost_profile.id}"

    key_name = "${var.default_keypair_name}"
    security_groups = ["${aws_security_group.schojak.id}"]

    user_data = <<EOF
#!/bin/bash
id
pwd
pip install ansible
mkdir /var/lib/bootstrap
aws s3 cp s3://schojak-jumphost-bootstrap/bootstrap.zip /var/lib/bootstrap/bootstrap.zip --region eu-central-1
unzip /var/lib/bootstrap/bootstrap.zip -d /var/lib/bootstrap/
chmod +x /var/lib/bootstrap/hosts/ec2.py
/usr/local/bin/ansible-playbook /var/lib/bootstrap/infra.yaml
EOF

    lifecycle {
      create_before_destroy = true
    }

    depends_on = [
        "aws_s3_bucket_object.bootstrap-package"
    ]
}

resource "aws_autoscaling_group" "bar" {
  vpc_zone_identifier = [ "${aws_subnet.schojak.id}" ]
  name = "${var.vpc_name}-jumphost-asg"
  max_size = 1
  min_size = 1
  health_check_grace_period = 300
  health_check_type = "EC2"
  desired_capacity = 1
  force_delete = false
  launch_configuration = "${aws_launch_configuration.jump_conf.name}"

  tag = [{
        key = "Owner"
        value = "${var.owner}"
        propagate_at_launch = true
      }, {
        key = "Application"
        value = "${var.application}"
        propagate_at_launch = true
      }, {
        key = "Confidentiality"
        value = "${var.confidentality}"
        propagate_at_launch = true
      }, {
        key = "Costcenter"
        value = "${var.costcenter}"
        propagate_at_launch = true
      }, {
        key = "ansibleFilter"
        value = "schojak"
        propagate_at_launch = true
      }, {
        key = "ansibleNodeType"
        value = "jumphost"
        propagate_at_launch = true
      }, {
        key = "ansibleNodeName"
        value = "jumphost-"
        propagate_at_launch = true
      }
  ]
  tag {
    key = "lorem"
    value = "ipsum"
    propagate_at_launch = false
  }
}

// resource "aws_instance" "jump" {
//     ami = "${var.default_ami}"
//     instance_type = "${var.jump_host_type}"
//
//     subnet_id = "${aws_subnet.schojak.id}"
//     associate_public_ip_address = true # Instances have public, dynamic IP
//
//     iam_instance_profile = "${aws_iam_instance_profile.jumphost_profile.id}"
//
//     availability_zone = "${var.zone}"
//     vpc_security_group_ids = ["${aws_security_group.schojak.id}"]
//     key_name = "${var.default_keypair_name}"
//
//     tags {
//       Name = "jump-host-1"
//       Owner = "${var.owner}"
//       Application = "${var.application}"
//       Confidentiality = "${var.confidentality}"
//       Costcenter = "${var.costcenter}"
//       ansibleFilter = "schojak"
//       ansibleNodeType = "jumphost"
//       ansibleNodeName = "jumphost1"
//     }
// }
