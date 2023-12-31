###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###
### Locals
###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###
### The naming standards used here are *loosely* based on Microsoft standards here:
### https://learn.microsoft.com/en-us/entra/identity/conditional-access/plan-conditional-access#set-naming-standards-for-your-policies
locals {
  policy_name = "${local.type_name}_${local.app_name}_with_${local.resp_name_final}_for_${local.target_name_final}_on_${local.con_name_final}"
  type_name   = contains(var.grant_controls, "block") == false ? "Allow" : "Block"
  app_name    = replace(length(var.included_apps) == 1 ? "${var.included_apps[0]}" : "${var.included_apps[0]}+Others", "/\\s+/", "")
}
locals {
  # These locals are used in the naming prefix for the policy response.
  resp_naming_table = { # This table exists to translate response names to a more readable format.
    block                = "LoginDenied",
    mfa                  = "RequireMFA",
    approvedapplication  = "ApprovedApp",
    compliantapplication = "CompliantApp",
    compliantdevice      = "CompliantDevice",
    domainjoineddevice   = "HybridJoined",
    passwordchange       = "PasswordReset",
    unknownfuturevalue   = "UFVInput-Error"
  }
  resp_list_prep = { # Preparing the response name based on functions and expressions for injestion by coalesce.
    override   = var.response_name_override != null ? "${var.response_name_override}" : ""
    mfa_hybrid = contains(var.grant_controls, "mfa") && contains(var.grant_controls, "domainJoinedDevice") && length(var.grant_controls) == 2 ? "MFA-Hybrid" : ""
    multi      = length(var.grant_controls) != 1 ? "${local.resp_naming_table[lower(var.grant_controls[0])]}-${local.grant_or}-Others" : ""
    single     = "${local.resp_naming_table[lower(var.grant_controls[0])]}"
  }
  resp_name_final = coalesce(local.resp_list_prep.override, local.resp_list_prep.mfa_hybrid, local.resp_list_prep.multi, local.resp_list_prep.single)
}
locals {
  # These locals are used in the naming prefix for the user/group entitlement or "target".
  target_list_prep = {
    override = var.target_name_override != null ? "${var.target_name_override}" : ""
    all      = alltrue([contains(var.included_users, "All"), contains(var.included_groups, "None"), contains(var.included_sps, "None")]) == true ? "All" : ""
    groups   = var.included_groups[0] != "None" ? length(var.included_groups) == 1 ? "${var.included_groups[0]}" : "Groups" : ""
    users    = var.included_users[0] != "All" ? length(var.included_users) == 1 ? "${var.included_users[0]}" : "Users" : ""
    sps      = var.included_sps[0] != "None" ? length(var.included_sps) == 1 ? "${var.included_sps[0]}" : "MultipleSPs" : ""
  }
  # The following two locals could be a single line with replace(coalesce(args), args), but this is easier to read.
  target_name_coalesce = coalesce(local.target_list_prep.override, local.target_list_prep.all, local.target_list_prep.groups, local.target_list_prep.users, local.target_list_prep.sps, "Error")
  target_name_final    = replace(local.target_name_coalesce, "/\\s+/", "")
}
locals {
  # These locals are used in the naming prefix for the non-identity/application based conditions.
  con_list_prep = {
    override         = var.con_name_override != null ? "${var.con_name_override}" : ""
    mobile           = alltrue([length(var.included_platforms) == 2, contains(var.included_platforms, "iOS"), contains(var.included_platforms, "android")]) == true ? "MobileDevices" : ""
    platforms        = var.included_platforms[0] != "all" ? length(var.included_platforms) == 1 ? "${var.included_platforms[0]}" : "MultiplePlatforms" : ""
    trusted_location = length(var.included_location_ids) == 1 && contains(var.included_location_ids, "AllTrusted") == true ? "TrustedLocations" : ""
    apptype          = var.client_app_types[0] != "all" ? length(var.client_app_types) == 1 ? "${var.client_app_types[0]}" : "MultipleClientTypes" : ""
    risk             = anytrue([contains(var.user_risk, "none"), contains(var.signin_risk, "none"), contains(var.sps_risk, "none")]) != true ? "RiskLevel" : ""
  }
  # The following two locals could be a single line with replace(coalesce(args), args), but this is easier to read.
  con_name_coalesce = coalesce(local.con_list_prep.override, local.con_list_prep.mobile, local.con_list_prep.platforms, local.con_list_prep.apptype, local.con_list_prep.risk, "All-Conditions")
  con_name_final    = replace(local.con_name_coalesce, "/\\s+/", "")
}
### Many of these locals have their expressions moved to the resource block.
### For the sake of readability, they will remain locals for now.
locals {
  state                         = var.state == "reportonly" ? "enabledForReportingButNotEnforced" : var.state
  grant_or                      = var.grant_or == true ? "OR" : "AND"
  by_hour                       = var.sign_in_frequency_by_hours == false ? "days" : "hours"
  included_external_membertypes = contains(var.excluded_external_membertypes, "none") == true ? [] : ["Loop the dynamic block."]
  excluded_external_membertypes = contains(var.included_external_membertypes, "none") == true ? [] : ["Loop the dynamic block."]
  included_ext_tenant_bool      = contains(var.included_external_tenant_ids, "none") == true ? "all" : "enumerated"
  excluded_ext_tenant_bool      = contains(var.excluded_external_tenant_ids, "none") == true ? "all" : "enumerated"
  excluded_platforms            = var.excluded_platforms[0] == "none" ? null : var.excluded_platforms
  excluded_location_ids         = var.excluded_location_ids[0] == "None" ? null : var.excluded_location_ids

}
### These locals prevent errors and extracts the required data object_id(s) into a list.
locals {
  apps = { ### Slightly different logic used for the applications than the ID(s) below.
    included = var.included_apps[0] == "All" ? tolist(var.included_apps) : tolist(data.azuread_application.included_apps[*].object_id)
    excluded = var.excluded_apps[0] == "None" ? tolist(var.excluded_apps) : tolist(data.azuread_application.excluded_apps[*].object_id)
  }
  users = {
    included = var.included_users[0] == "None" ? var.included_users : flatten(data.azuread_users.included_users[*].object_ids)
    excluded = var.excluded_users[0] == "None" ? var.excluded_users : flatten(data.azuread_users.excluded_users[*].object_ids)
  }
  groups = {
    included = var.included_groups[0] == "None" ? var.included_groups : flatten(data.azuread_groups.included_groups[*].object_ids)
    excluded = var.excluded_groups[0] == "None" ? var.excluded_groups : flatten(data.azuread_groups.excluded_groups[*].object_ids)
  }
  sps = {
    included = var.included_sps[0] == "None" ? var.included_sps : flatten(data.azuread_service_principals.included_sps[*].object_ids)
    excluded = var.excluded_sps[0] == "None" ? var.excluded_sps : flatten(data.azuread_service_principals.excluded_sps[*].object_ids)
  }
}
locals {
  group_name = "CAPEG_${local.policy_name}"
  group_description = "This group is an exclusions to the condtional access policy, ${local.policy_name}. This group was created by Terraform."
}