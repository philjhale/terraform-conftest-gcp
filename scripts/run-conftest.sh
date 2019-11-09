#!/bin/sh
docker run --rm -v $(pwd):/project -v $(pwd)/policy:/policy  instrumenta/conftest test project/terraform.tfplan.json