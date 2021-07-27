provider "aws" {
  region                      = "eu-central-1"
  access_key                  = "not-a-real-access-key"
  secret_key                  = "not-a-real-secret-key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_force_path_style         = true

  endpoints {
    s3 = "http://localhost:4572"
  }
}

module "basic_website" {
  source = "../../modules/s3-website"

  bucket_name = var.basic_website_bucket_name
  base_path   = var.basic_website_source_base_path
}