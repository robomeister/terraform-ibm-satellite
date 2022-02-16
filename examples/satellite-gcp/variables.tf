
variable "gcp_network_name" {
  description = "GCP VPC Network Name"
  type        = string
}
variable "gcp_subnetwork" {
  description = "GCP Subnet ID"
  type        = string
}


# # ##################################################
# # # GCP and IBM Authentication Variables
# # ##################################################

variable "gcp_project" {
  description = "GCP Project ID"
  type        = string
}
variable "gcp_region" {
  description = "Google Region"
  type        = string
  default     = "northamerica-northeast2"
}
variable "gcp_credentials" {
  description = "Either the path to or the contents of a service account key file in JSON format."
  type        = string
}
variable "ibmcloud_api_key" {
  description = "IBM Cloud API Key"
  type        = string
}
variable "ibm_resource_group" {
  description = "Resource group name of the IBM Cloud account."
  type        = string
  default     = "lcl"
}

# # ##################################################
# # # Google Resources Variables
# # ##################################################

variable "gcp_resource_prefix" {
  description = "Name to be used on all gcp resource as prefix"
  type        = string
  default     = "lcl-gcp"

  validation {
    condition     = var.gcp_resource_prefix != "" && length(var.gcp_resource_prefix) <= 25
    error_message = "Sorry, please provide value for resource_prefix variable or check the length of resource_prefix it should be less than 25 chars."
  }
}
variable "satellite_host_count" {
  description = "The total number of GCP host to create for control plane. satellite_host_count value should always be in multiples of 3, such as 3, 6, 9, or 12 hosts"
  type        = number
  default     = 3
  validation {
    condition     = (var.satellite_host_count % 3) == 0 && var.satellite_host_count > 0
    error_message = "Sorry, host_count value should always be in multiples of 3, such as 6, 9, or 12 hosts."
  }
}
variable "addl_host_count" {
  description = "The total number of additional gcp host"
  type        = number
  default     = 3
}
variable "instance_type" {
  description = "The type of gcp instance to start."
  type        = string
  default     = "n2-standard-16"
}
variable "ssh_public_key" {
  description = "SSH Public Key. Get your ssh key by running `ssh-key-gen` command"
  type        = string
  default     = null
}
variable "gcp_ssh_user" {
  description = "SSH User of above provided ssh_public_key"
  type        = string
  default     = null
}
# # ##################################################
# # # IBMCLOUD Satellite Location Variables
# # ##################################################

variable "location" {
  description = "Location Name"
  default     = "lcl-gcp-satellite"

  validation {
    condition     = var.location != "" && length(var.location) <= 32
    error_message = "Sorry, please provide value for location_name variable or check the length of name it should be less than 32 chars."
  }
}
variable "is_location_exist" {
  description = "Determines if the location has to be created or not"
  type        = bool
  default     = false
}

variable "managed_from" {
  description = "The IBM Cloud region to manage your Satellite location from. Choose a region close to your on-prem data center for better performance."
  type        = string
  default     = "tor"
}

variable "location_zones" {
  description = "Allocate your hosts across these three zones"
  type        = list(string)
  default     = ["northamerica-northeast2-a","northamerica-northeast2-b","northamerica-northeast2-c"]
}

variable "location_bucket" {
  description = "COS bucket name"
  default     = ""
}

variable "host_labels" {
  description = "Labels to add to attach host script"
  type        = list(string)
  default     = ["env:prod"]

  validation {
    condition     = can([for s in var.host_labels : regex("^[a-zA-Z0-9:]+$", s)])
    error_message = "Label must be of the form `key:value`."
  }
}

variable "TF_VERSION" {
  description = "Terraform version"
  type        = string
  default     = "0.13"
}
