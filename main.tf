locals {
  common_tags = {
    Project = var.project
    Owner   = var.owner
    Env     = var.env
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-research"
  location = var.location
  tags     = local.common_tags
}
