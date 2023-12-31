###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###
### Data
###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###
### https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application
data "azuread_application" "included_apps" {
  count        = var.included_apps[0] != "All" ? length(var.included_apps) : 0
  display_name = var.included_apps[count.index]
}
data "azuread_application" "excluded_apps" {
  count        = var.excluded_apps[0] != "None" ? length(var.excluded_apps) : 0
  display_name = var.excluded_apps[count.index]
}
### https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/groups
data "azuread_groups" "included_groups" {
  count         = var.included_groups[0] != "None" ? 1 : 0
  display_names = var.included_groups
}
data "azuread_groups" "excluded_groups" {
  count         = var.excluded_groups[0] != "None" ? 1 : 0
  display_names = var.excluded_groups
}
### https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/users
data "azuread_users" "included_users" {
  count                = var.included_users[0] != "None" ? var.included_users[0] != "All" ? 1 : 0 : 0
  user_principal_names = var.included_users
}
data "azuread_users" "excluded_users" {
  count                = var.excluded_users[0] != "None" ? 1 : 0
  user_principal_names = var.excluded_users
}
### https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principals
data "azuread_service_principals" "included_sps" {
  count         = var.included_sps[0] != "None" ? 1 : 0
  display_names = var.included_sps
}
data "azuread_service_principals" "excluded_sps" {
  count         = var.excluded_sps[0] != "None" ? 1 : 0
  display_names = var.excluded_sps
}