variable "region" {
  default = "eu-west-1"
}

provider "aws" {
  version = "~> 3.1, != 3.14.0"
  region  = var.region
}

provider "template" {
  version = "~> 2.1.2"
}

