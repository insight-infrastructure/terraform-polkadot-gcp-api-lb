########
# Label
########
variable "environment" {
  description = "The environment"
  type        = string
  default     = ""
}

variable "namespace" {
  description = "The namespace to deploy into"
  type        = string
  default     = ""
}

variable "stage" {
  description = "The stage of the deployment"
  type        = string
  default     = ""
}

variable "network_name" {
  description = "The network name, ie kusama / mainnet"
  type        = string
  default     = ""
}

variable "owner" {
  type    = string
  default = ""
}

########
# Load Balancer
########

variable "lb_name" {
  description = "Name for load balancer"
  type        = string
  default     = "rpc-lb"
}

variable "use_external_lb" {
  description = "Bool to switch between public (true) or private (false)"
  type        = bool
  default     = false
}

variable "public_vpc_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "instance_group_id" {
  type = string
}

variable "region" {
  type    = string
  default = "us-east1"
}