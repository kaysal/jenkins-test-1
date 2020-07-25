#!/bin/bash

# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
echo "STARTING tf-wrapper HERE-"

branchname=$2
policyrepo=$3

#tf_validator_path="./terraform-validator-linux-amd64"
tf_validator_path="/usr/local/bin/terraform-validator"

##functions
tf_apply() {
  terraform apply -input=false -auto-approve "${branchname}.tfplan" || exit 1
}

tf_init() {
  terraform init || exit 11
}

tf_plan() {
  terraform plan -input=false -out "${branchname}.tfplan" || exit 21
}

tf_validate() {
  if ! ${tf_validator_path} version &> /dev/null; then
    echo "terraform-validator not found!  Check path or visit"
    echo "https://github.com/forseti-security/policy-library/blob/master/docs/user_guide.md#how-to-use-terraform-validator"
  else
    terraform show -json "${branchname}.tfplan" > "${branchname}.json" || exit 32
    ${tf_validator_path} validate "${branchname}.json" --policy-path="${policyrepo}" || exit 33
  fi
}

##main
case "$1" in
  apply )
    echo "*************** TERRAFORM APPLY *******************"
    echo "      At environment: ${branchname} "
    echo "***************************************************"

    cd ../1-org/envs/shared || exit 44
    # cd "./envs/${branchname}" || exit 44

    if [ ! -d ".terraform" ]; then
      tf_init
    fi

    if [ ! -f "${branchname}.tfplan" ]; then
      tf_plan
    fi

    tf_validate

    tf_apply
    ;;

  init )
    echo "*************** TERRAFORM INIT *******************"
    echo "      At environment: ${branchname} "
    echo "**************************************************"
    
    #     echo "1 - WHAT DIRECTORY ARE WE IN?"
    #     echo "`pwd`"
    #     echo "1 - -----------------------------------"

    #     echo "2 - SEE THE OUTPUT FOR gcloud auth list"
    #     gcloud auth list
    #     echo "2 - -----------------------------------"

    #     echo "3 - CHANGE THE ACCOUT WITH gcloud config set account org-terraform@cft-seed-fe85.iam.gserviceaccount.com"
    #     gcloud config set account org-terraform@cft-seed-fe85.iam.gserviceaccount.com
    #     echo "3 - -----------------------------------"

    #     echo "3.1 - IMPERSONATE THE TERRAFORM ACCOUNT gcloud config set auth/impersonate_service_account org-terraform@cft-seed-fe85.iam.gserviceaccount.com"
    #     gcloud config set auth/impersonate_service_account org-terraform@cft-seed-fe85.iam.gserviceaccount.com
    #     echo "3.1 - -----------------------------------"

    #     echo "4 - SEE THE NEW OUTPUT FOR gcloud auth list"
    #     gcloud auth list
    #     echo "4 - -----------------------------------"
    
    cd ../1-org/envs/shared || exit 44
    # cd "./envs/${branchname}" || exit 44

    tf_init
    ;;

  plan )
    echo "*************** TERRAFORM PLAN *******************"
    echo "      At environment: ${branchname} "
    echo "**************************************************"

    cd ../1-org/envs/shared || exit 44
    # cd "./envs/${branchname}" || exit 44

    if [ ! -d ".terraform" ]; then
      tf_init
    fi

    tf_plan
    ;;

  validate )
    echo "*************** TERRAFORM VALIDATE ******************"
    echo "      At environment: ${branchname} "
    echo "      Using policy from: ${policyrepo} "
    echo "****************************************************"

    cd ../1-org/envs/shared || exit 44
    # cd "./envs/${branchname}" || exit 44

    if [ ! -d ".terraform" ]; then
      tf_init
    fi

    if [ ! -f "${branchname}.tfplan" ]; then
      tf_plan
    fi

    tf_validate
    ;;
  * )
    echo "unknown option: ${1}"
    exit 99
    ;;
esac
