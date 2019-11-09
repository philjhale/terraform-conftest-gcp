# terraform-conftest-gcp

Playground for validating Terraform plans using Conftest.

# Prerequisites
- Terraform
- GCP project
- Google Cloud SDK
- Docker

# Local set up
Set up environment variables.
```
export GOOGLE_PROJECT_ID=my-project-id
export TF_VAR_google_project_id=my-project-id
export GOOGLE_APPLICATION_CREDENTIALS=path-to-credentials
```

Init terraform, generate plan and validate.
```
terraform init -backend-config=bucket=${GOOGLE_PROJECT_ID}_terraform
terraform plan --out=terraform.tfplan
terraform show -json ./terraform.tfplan > ./terraform.tfplan.json
```

Run Conftest.
```
docker run --rm -v $(pwd):/project -v $(pwd)/policy:/policy instrumenta/conftest test project/terraform.tfplan.json
```

Example fail output.
```
FAIL - project/terraform.tfplan.json - bucket-with-a-name-that-is-too-long-0000000000000000000000000000 - Storage bucket names must be between 3 and 63 characters
FAIL - project/terraform.tfplan.json - bucket-missing-environment-label - Storage buckets must have an env label with one of the following values: dev, qa, prod
FAIL - project/terraform.tfplan.json - bucket-invalid-environment-label - Storage buckets env label must be one of the following values: dev, qa, prod
```

# Cloud Build set up
```
gcloud builds submit .
```

# Links

- [Rego safety FAQ](https://www.openpolicyagent.org/docs/latest/faq/#safety)


docker run --rm -it -v $(pwd):/project --entrypoint=/bin/sh instrumenta/conftest 