variable "location" {
  description = "Azure region for deployment"
  default     = "eastasia"
}

variable "project" {
  description = "Project tag for all resources"
  default     = "Genomics"
}

variable "owner" {
  description = "Resource owner (used in tags)"
  default     = "Harshitha"
}

variable "env" {
  description = "Environment tag for all resources"
  default     = "PoC"
}

variable "cidr_vnet" {
  description = "VNet Address Space"
  default     = "10.10.0.0/20"
}

variable "cidr_backend" {
  description = "Backend subnet CIDR"
  default     = "10.10.0.0/24"
}

variable "cidr_jumphost" {
  description = "Jumphost subnet CIDR"
  default     = "10.10.1.0/24"
}

variable "cidr_hpc" {
  description = "HPC subnet CIDR"
  default     = "10.10.2.0/24"
}

variable "jumphost_allowed_ip" {
  description = "Public IP CIDR allowed for RDP to jumphost"
  default     = "103.57.133.216/32"
}
