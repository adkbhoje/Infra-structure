variable "accessKey" {
  type        = "string"
  description = "AWS access key id"
  default = "missing"
}

variable "secretKey" {
  type        = "string"
  description = "AWS access secret key"
  default = "missing"
}

provider "aws" {
  access_key = "${var.accessKey}"
  secret_key = "${var.secretKey}"
  region     = "us-east-1"
}
resource "aws_security_group" "NSRA-WL-Webapps-TLS_sus" {
  name   = "NSRA-WL-Webapps-TLS_sus"
  vpc_id = "vpc-0eaa852c4918ad316"

  # SSH access from the VPC
  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "NSRA-sg-80-TF"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["sushil-packer-ami*"]
  }
  owners = ["254974886611"]
}

resource "aws_instance" "example" {
  #ami           = ""
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = "cloud_infra_key1"
  tags = {
    Name ="cloud_infra_server_1"
    }
}
resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = aws_security_group.NSRA-WL-Webapps-TLS_sus.id
  network_interface_id = aws_instance.example.primary_network_interface_id
}

#resource "aws_s3_bucket" "b" {
 #  bucket = "my-tf-test-bucket-sushil"
 # acl    = "private"

 # tags = {
 #   Name        = "My bucket sushil"
  #  Environment = "Dev"
  #}
#}
