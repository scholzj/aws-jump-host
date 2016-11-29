provider "archive" {
}

data "archive_file" "bootstrap" {
    type        = "zip"
    source_dir = "${path.module}/../ansible"
    output_path = "${path.module}/../bootstrap.zip"
}

resource "aws_s3_bucket" "jumphost-bootstrap" {
    bucket = "${var.vpc_name}-jumphost-bootstrap"
    acl = "private"

    tags {
        Name = "${var.vpc_name}"
        Owner = "${var.owner}"
        Application = "${var.application}"
        Confidentiality = "${var.confidentality}"
        Costcenter = "${var.costcenter}"
    }
}

resource "aws_s3_bucket_object" "bootstrap-package" {
    depends_on = [
        "aws_s3_bucket.jumphost-bootstrap"
    ]

    bucket = "${var.vpc_name}-jumphost-bootstrap"
    key = "bootstrap.zip"
    source = "${path.module}/../bootstrap.zip"
}
