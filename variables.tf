variable "architecture" {
  type = string
}

variable "hypervisor_type" {
  type    = string
  default = "kvm"
}

variable "disk_format" {
  type    = string
  default = "qcow2"
}

variable "container_format" {
  type    = string
  default = "bare"
}

variable "install_defaults" {
  type = object({
    almalinux  = optional(bool, true)
    rockylinux = optional(bool, true)
    ubuntu     = optional(bool, true)
  })
  default = {}
}

# Alma Linux specifc variables

variable "almalinux_defaults" {
  type = object({
    url_tmpl         = optional(string, "https://repo.almalinux.org/almalinux/$${version}/cloud/$${architecture}/images/AlmaLinux-$${version_major}-GenericCloud-latest.$${architecture}.qcow2")
    secure_execution = optional(string, "False")
  })
  default = {}
}

variable "almalinux_versions" {
  type = map(object({
    url              = optional(string, null)
    secure_execution = optional(string, "False")
  }))
  default = {}
}

# Rocky Linux specifc variables

variable "rockylinux_defaults" {
  type = object({
    url_tmpl         = optional(string, "https://dl.rockylinux.org/pub/rocky/$${version}/images/$${architecture}/Rocky-$${version_major}-GenericCloud-Base.latest.$${architecture}.qcow2")
    secure_execution = optional(string, "False")
  })
  default = {}
}

variable "rockylinux_versions" {
  type = map(object({
    url              = optional(string, null)
    secure_execution = optional(string, "False")
  }))
  default = {}
}

# Ubuntu specific variables

variable "ubuntu_defaults" {
  type = object({
    url_tmpl         = optional(string, "https://cloud-images.ubuntu.com/$${codename}/current/$${codename}-server-cloudimg-$${architecture}.img")
    secure_execution = optional(string, "False")
  })
  default = {}
}

variable "ubuntu_versions" {
  type = map(object({
    version          = optional(string, null)
    url              = optional(string, null)
    secure_execution = optional(string, "False")
  }))
  default = {}
}
