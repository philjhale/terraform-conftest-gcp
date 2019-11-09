#!/bin/sh
terraform plan --out=terraform.tfplan
terraform show -json ./terraform.tfplan > ./terraform.tfplan.json