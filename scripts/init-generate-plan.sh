#!/bin/sh
terraform init -backend-config=bucket=${GOOGLE_PROJECT_ID}_terraform
terraform plan --out=terraform.tfplan
terraform show -json ./terraform.tfplan > ./terraform.tfplan.json