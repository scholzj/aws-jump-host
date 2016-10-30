# Source IP

variable control_cidr {
  default = ["88.208.76.87/32", "193.29.76.161/32"]
}

# Key

variable default_keypair_public_key {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQChoLeLJuKatYaHIchuGh3xmKGpW2RGcTKb7PjWpxUs4IQKB22WNkcigql1t9STRBg5QPU4UXG3veNv45GQynDcBBtv/TtnOd+PeJX07+bfcaiffKyQ2MvqrL242Bn4iD3I+W8GYW6/GfuLwANgnD0bDfrABJczRZYvZTInre5DvBzcLssKsCzmbCsGPEy4rkM/asd/LGHcLqJXadklTBYxyOEhj84P2N5SE7mEbNEljsTH0OSS2bC3dq5NMl3sbAJPFow4na2OZ0MgteTN4leD3jguoK/PWrgIQawzSQlF5q46X9VmR9apafWzaCEZljgEe3WuzEABsNq0A14kMfcz"
}

variable default_keypair_name {
  default = "schojak"
}

# Tags

variable application {
  default = "None"
}

variable confidentality {
  default = "None"
}

variable costcenter {
  default = "000000"
}

variable owner {
  default = "schojak"
}

# Regional setup

variable region {
  default = "eu-central-1"
}

variable zone {
  default = "eu-central-1a"
}

# VPC setup

variable vpc_name {
  default = "schojak"
}

variable vpc_cidr {
  default = "172.34.0.0/24"
}

# Instances Setup
variable default_ami {
  default = "ami-0044b96f"
}

variable default_instance_user {
  default = "ec2-user"
}

variable jump_host_type {
  default = "t2.micro"
}
