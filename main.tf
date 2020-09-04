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
  key_name = "test2"
  #security_group_id = "sg-022e979bc54764d78"
}

#resource "aws_s3_bucket" "b" {
 #  bucket = "my-tf-test-bucket-sushil"
 # acl    = "private"

 # tags = {
 #   Name        = "My bucket sushil"
  #  Environment = "Dev"
  #}
#}
