data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "saurabh-bucket-tf"
    key    = "dev/tf-vpc/teraform.tfstate"
    region = "us-east-1"
  }
}
