terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.39.0"
    }
        github = {
      source = "integrations/github"
      version = "6.0.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}


provider "github" {
# Configuration options or GITHUB_TOKEN env variable
token=data.aws_ssm_parameter.ornek_parametre.value
 }



 
