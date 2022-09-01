#!/bin/bash
git clone https://github.com/sravan-github/terraformgcp.git
cd terraformgcp
ls -l
pwd
export GOOGLE_APPLICATION_CREDENTIALS="./gcp-key.json"
terraform init
terraform plan
