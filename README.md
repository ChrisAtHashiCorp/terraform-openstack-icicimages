# Terraform ICIC (IBM Cloud Infrastructure Center) Base Images Module

Quickly and reproducably deploy official base cloud images onto ICIC for
several Linux distros.

Currently this module supports deploying the following images:
- Rocky Linux
  - 9.6
  - 10.0
- Ubuntu
  - 22.04 LTS (Jammy)
  - 24.04 LTS (Noble)

## Requirements
- Terraform >= 1.13.1
- OpenStack Provider >= 3.3.2
