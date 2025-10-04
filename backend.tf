terraform {
  backend "s3" {
    bucket         = "bucket-name" # WILL ADD UP AFTER COMPLETING ROOT MODULE
    key            = "/terraform.tfstate"    
    region         = "us-east-1" # CURRENT REGION                    
    dynamodb_table = "dynamo-db" # WILL ADD UP AFTER COMPLETING ROOT MODULE AS IT COSTS
    encrypt        = true
  }
}
