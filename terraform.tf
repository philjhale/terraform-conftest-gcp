terraform {
  backend "gcs" {
    # bucket = "" Set this using the command line. E.g. terraform init -backend-config=bucket=${GOOGLE_PROJECT_ID}_terraform
    prefix = "terraform/state"
  }
}