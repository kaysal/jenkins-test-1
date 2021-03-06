/**
 * Copyright 2020 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "terraform_service_account" {
  description = "Service account email of the account to impersonate to run Terraform"
  type        = string
}

variable "org_id" {
  description = "The organization id for the associated services"
  type        = string
}

variable "billing_account" {
  description = "The ID of the billing account to associated this project with"
  type        = string
}

variable "default_region" {
  description = "Default region for subnet."
  type        = string
}

variable "skip_gcloud_download" {
  description = "Whether to skip downloading gcloud (assumes gcloud is already available outside the module)"
  type        = bool
  default     = true
}

variable "env_code" {
  description = "A short form of the environment field"
  type        = string
}

variable "vpc_type" {
  description = "The type of VPC to attach the project to (base, rest, etc)"
  type        = string
}

/******************************************
  Private DNS Management (Optional)
 *****************************************/
# variable "domain" {
#   description = "The top level domain name for the organization"
#   type        = string
# }

variable "parent_folder" {
  description = "Optional - if using a folder for testing."
  type        = string
  default     = ""
}
