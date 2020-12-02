terraform {
  required_version = ">= 0.13"

  backend "http" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.0"
    }
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 0.7"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 2.2"
    }
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

