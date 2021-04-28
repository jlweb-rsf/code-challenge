
## Using this module to persist and lock the \
## terraform state (to prevent race condition) to the \
## S3 bucket and DynamoDB as the remote storage.
module "terraform_state_backend" {
   source = "cloudposse/tfstate-backend/aws"
   version     = "0.33.0"
   namespace  = "Assignment"
   stage      = "DEV"
   name       = "terraform"
   attributes = ["state"]

   terraform_backend_config_file_path = "."
   terraform_backend_config_file_name = "provider.tf"
   force_destroy                      = false
 }

