module "gcs_buckets" {
  source     = "terraform-google-modules/cloud-storage/google"
  project_id = var.google_project_id
  names      = ["bucket-with-a-name-that-is-too-long-0000000000000000000000000000"]
  prefix     = ""
  labels = {
    env = "dev"
  }
}

module "gcs_buckets2" {
  source     = "terraform-google-modules/cloud-storage/google"
  project_id = var.google_project_id
  names      = ["bucket-missing-environment-label"]
  prefix     = ""
  labels = {

  }
}

module "gcs_buckets3" {
  source     = "terraform-google-modules/cloud-storage/google"
  project_id = var.google_project_id
  names      = ["bucket-invalid-environment-label"]
  prefix     = ""
  labels = {
    env = "devvvv"
  }
}