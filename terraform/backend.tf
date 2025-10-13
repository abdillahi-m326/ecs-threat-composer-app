terraform {
  backend "s3" {
    bucket = "my-terraform-tfstate-b-326995"
    key    = "ecs-fargate/terraform.tfstate"
    region = "us-east-1"
  }
}
