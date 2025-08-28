# Kind of a disgusting hack to take the single sensitive property out of the
# image resource for outputting. 

locals {
  rockylinux-images-output = {
    for image, properties in openstack_images_image_v2.rockylinux : image => {
      for property, value in properties : property => value if property != "image_source_password"
    }
  }

  ubuntu-images-output = {
    for image, properties in openstack_images_image_v2.ubuntu : image => {
      for property, value in properties : property => value if property != "image_source_password"
    }
  }
}

output "rockylinux-images" {
  value = local.rockylinux-images-output[*]
}

output "ubuntu-images" {
  value = local.ubuntu-images-output[*]
}
