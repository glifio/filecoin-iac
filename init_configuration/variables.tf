# https://wikiprojects.upc.biz/display/SPARK/AWS+Account+architecture
variable "profile" {
  type = map(string)

  default = {
    "filecoin-glif-mainnet-apn1" = "filecoin"
    "filecoin-glif-dev-apn1"     = "filecoin"
  }
}

variable "tf_state_s3_bucket" {
  type = string
}

variable "tf_state_dynamodb_table" {
  type = string
}

variable "region" {
  type = string
}

variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "sub_environment" {
  type = string
}
