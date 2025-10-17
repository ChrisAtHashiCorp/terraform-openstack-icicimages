terraform {
  required_version = ">= 1.13.1"

  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = ">= 3.3.2"
    }
  }
}
