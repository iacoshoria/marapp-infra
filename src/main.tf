terraform {
  required_version = ">= 0.12"
  required_providers {
    aws          = "~> 2.0"
    mongodbatlas = "~> 0.5"
    random       = "~> 2.2"
  }
}

provider "aws" {
  region = var.aws_region

}

provider "mongodbatlas" {
  public_key  = var.mongodb_atlas_public_key
  private_key = var.mongodb_atlas_private_key
}

locals {
  tags = {
    Application = "marapp"
    ManagedBy   = "Terraform"
    Environment = var.environment_name
  }
}

