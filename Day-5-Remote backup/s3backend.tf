terraform {
  backend "s3" {
    bucket = "test-env01"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}