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

variable "org_id" {
  description = "The organization id for the associated services"
  type        = string
}

variable "billing_account" {
  description = "The ID of the billing account to associate this project with"
  type        = string
}

variable "terraform_service_account" {
  description = "Service account email of the account to impersonate to run Terraform."
  type        = string
}

variable "default_region" {
  description = "Default region for BigQuery resources."
  type        = string
}

variable "billing_data_users" {
  description = "Gsuite or Cloud Identity group that have access to billing data set."
  type        = string
}

variable "audit_data_users" {
  description = "Gsuite or Cloud Identity group that have access to audit logs."
  type        = string
}

variable "domains_to_allow" {
  description = "The list of domains to allow users from in IAM."
  type        = list(string)
}

variable "access_table_expiration_ms" {
  description = "Period before tables expire for access logs in milliseconds. Default is 400 days."
  type        = number
  default     = 34560000000
}

variable "system_event_table_expiration_ms" {
  description = "Period before tables expire for system event logs in milliseconds. Default is 400 days."
  type        = number
  default     = 34560000000
}

variable "vpc_flow_table_expiration_ms" {
  description = "Period before tables expire for vpc flow logs in milliseconds. Default is 400 days."
  type        = number
  default     = 34560000000
}

variable "access_transparency_table_expiration_ms" {
  description = "Period before tables expire for access transparency logs in milliseconds. Default is 400 days."
  type        = number
  default     = 34560000000
}

variable "firewall_rules_table_expiration_ms" {
  description = "Period before tables expire for firewall rules logs in milliseconds. Default is 400 days."
  type        = number
  default     = 34560000000
}

variable "data_access_table_expiration_ms" {
  description = "Period before tables expire for data access logs in milliseconds. Default is 30 days."
  type        = number
  default     = 2592000000
}

variable "scc_notification_name" {
  description = "Name of SCC Notification"
  type        = string
}

variable "skip_gcloud_download" {
  description = "Whether to skip downloading gcloud (assumes gcloud is already available outside the module. If set to true you, must ensure that Gcloud Alpha module is installed.)"
  type        = bool
  default     = true
}

variable "scc_notification_filter" {
  description = "Filter used to SCC Notification, you can see more details how to create filters in https://cloud.google.com/security-command-center/docs/how-to-api-filter-notifications#create-filter"
  type        = string
  default     = "state=\\\"ACTIVE\\\""
}

variable "parent_folder" {
  description = "Optional - if using a folder for testing."
  type        = string
  default     = ""
}

variable "create_access_context_manager_access_policy" {
  description = "Whether to create access context manager access policy"
  type        = bool
  default     = true
}

variable "data_access_logs_enabled" {
  description = "Enable Data Access logs of types DATA_READ, DATA_WRITE and ADMIN_READ for all GCP services. Enabling Data Access logs might result in your organization being charged for the additional logs usage. See https://cloud.google.com/logging/docs/audit#data-access"
  type        = bool
  default     = true
}
