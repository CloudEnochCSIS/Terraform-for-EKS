terraform {
  backend "s3" {
    bucket         = "akpa-aws-eks-infra"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "eks-infra"
    profile        = "DevOps-Admin"
  }
}