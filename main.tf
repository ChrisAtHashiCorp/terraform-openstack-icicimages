# Alma Linux

locals {
  almalinux_defvers_map = { "9.6" = {}, "10.0" = {} }
  almalinux_defvers     = var.install_defaults.almalinux ? local.almalinux_defvers_map : null
  almalinux_vers_merged = merge(var.almalinux_versions, local.almalinux_defvers)
}

resource "openstack_images_image_v2" "almalinux" {
  for_each = local.almalinux_vers_merged

  name = "almalinux-${each.key}"
  image_source_url = coalesce(try(each.value.url, null), templatestring(var.almalinux_defaults.url_tmpl, {
    version       = each.key,
    architecture  = var.architecture,
    version_major = split(".", each.key)[0]
  }))
  disk_format      = var.disk_format
  container_format = var.container_format

  properties = {
    hypervisor_type  = var.hypervisor_type
    architecture     = var.architecture
    secure_execution = coalesce(try(each.value.secure_execution, null), var.almalinux_defaults.secure_execution)
    os_distro        = "Alma-${each.key}"
    powervc_comments = "This base image is managed by Terraform."
  }

  tags = ["Alma", "Alma-${split(".", each.key)[0]}", "Alma${each.key}"]

  lifecycle {
    ignore_changes = [image_cache_path]
  }
}

# Rocky Linux

locals {
  rockylinux_defvers_map = { "9.6" = {}, "10.0" = {} }
  rockylinux_defvers     = var.install_defaults.rockylinux ? local.rockylinux_defvers_map : null
  rockylinux_vers_merged = merge(var.rockylinux_versions, local.rockylinux_defvers)
}

resource "openstack_images_image_v2" "rockylinux" {
  for_each = local.rockylinux_vers_merged

  name = "rockylinux-${each.key}"
  image_source_url = coalesce(try(each.value.url, null), templatestring(var.rockylinux_defaults.url_tmpl, {
    version       = each.key,
    architecture  = var.architecture,
    version_major = split(".", each.key)[0]
  }))
  disk_format      = var.disk_format
  container_format = var.container_format

  properties = {
    hypervisor_type  = var.hypervisor_type
    architecture     = var.architecture
    secure_execution = coalesce(try(each.value.secure_execution, null), var.rockylinux_defaults.secure_execution)
    os_distro        = "RHEL${each.key}"
    powervc_comments = "This base image is managed by Terraform."
  }

  tags = ["RHEL", "RHEL${split(".", each.key)[0]}", "RHEL${each.key}"]

  lifecycle {
    ignore_changes = [image_cache_path]
  }
}

# Ubuntu Linux

locals {
  ubuntu_defvers_map = { "noble" = { version = "24.04" }, "jammy" = { version = "22.04" } }
  ubuntu_defvers     = var.install_defaults.ubuntu ? local.ubuntu_defvers_map : null
  ubuntu_vers_merged = merge(var.ubuntu_versions, local.ubuntu_defvers)
}

resource "openstack_images_image_v2" "ubuntu" {
  for_each = local.ubuntu_vers_merged

  name = "ubuntu-${each.key}"
  image_source_url = coalesce(try(each.value.url, null), templatestring(var.ubuntu_defaults.url_tmpl, {
    codename     = each.key,
    architecture = var.architecture,
  }))
  disk_format      = var.disk_format
  container_format = var.container_format

  properties = {
    hypervisor_type  = var.hypervisor_type
    architecture     = var.architecture
    secure_execution = coalesce(try(each.value.secure_execution, null), var.ubuntu_defaults.secure_execution)
    os_distro        = "Ubuntu"
    powervc_comments = "This base image is managed by Terraform."
  }

  tags = compact(["Ubuntu", "Ubuntu ${each.key}", try("Ubuntu ${each.value.version}", null)])

  lifecycle {
    ignore_changes = [image_cache_path]
  }
}
