
#########################
# Jump host instance
#########################

resource "aws_instance" "jump" {
    ami = "${var.default_ami}"
    instance_type = "${var.jump_host_type}"

    subnet_id = "${aws_subnet.schojak.id}"
    associate_public_ip_address = true # Instances have public, dynamic IP

    iam_instance_profile = "${aws_iam_instance_profile.jumphost_profile.id}"

    availability_zone = "${var.zone}"
    vpc_security_group_ids = ["${aws_security_group.schojak.id}"]
    key_name = "${var.default_keypair_name}"

    tags {
      Name = "jump-host-1"
      Owner = "${var.owner}"
      Application = "${var.application}"
      Confidentiality = "${var.confidentality}"
      Costcenter = "${var.costcenter}"
      ansibleFilter = "schojak"
      ansibleNodeType = "jumphost"
      ansibleNodeName = "jumphost1"
    }
}
