# terraform-conftest-gcp

Playground for validating Terraform plans using Conftest

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
docker run --rm -v $(pwd):/project -v $(pwd)/policy:/policy  instrumenta/conftest test project/terraform.tfplan.json
```

# Cloud Build set up

```
gcloud builds submit .
```

# Links

- [Rego safety FAQ](https://www.openpolicyagent.org/docs/latest/faq/#safety)


docker run --rm -it -v $(pwd):/project --entrypoint=/bin/sh instrumenta/conftest 