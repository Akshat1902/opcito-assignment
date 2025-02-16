locals {
  apps = jsondecode(file("applications.json")).applications
}
