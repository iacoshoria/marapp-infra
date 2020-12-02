/*
  Copyright 2018-2020 National Geographic Society

  Use of this software does not constitute endorsement by National Geographic
  Society (NGS). The NGS name and NGS logo may not be used for any purpose without
  written permission from NGS.

  Licensed under the Apache License, Version 2.0 (the "License"); you may not use
  this file except in compliance with the License. You may obtain a copy of the
  License at

      https://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software distributed
  under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
  CONDITIONS OF ANY KIND, either express or implied. See the License for the
  specific language governing permissions and limitations under the License.
*/

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

