###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###
### Resources
###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###
resource "azuread_conditional_access_policy" "policy" {
  display_name = local.policy_name
  state        = local.state
  conditions {
    client_app_types              = var.client_app_types
    user_risk_levels              = var.user_risk
    sign_in_risk_levels           = var.signin_risk
    service_principal_risk_levels = var.sps_risk
    applications {
      included_applications = local.apps.included
      excluded_applications = local.apps.excluded
    }
    users {
      included_users  = local.users.included
      excluded_users  = local.users.excluded
      included_groups = local.groups.included
      excluded_groups = local.groups.excluded
      dynamic "included_guests_or_external_users" {
        for_each = local.included_external_membertypes
        content {
          guest_or_external_user_types = var.included_external_membertypes
          external_tenants {
            membership_kind = local.included_ext_tenant_bool
            members         = var.included_external_tenant_ids
          }
        }
      }
      dynamic "excluded_guests_or_external_users" {
        for_each = local.excluded_external_membertypes
        content {
          guest_or_external_user_types = var.excluded_external_membertypes
          external_tenants {
            membership_kind = local.excluded_ext_tenant_bool
            members         = var.excluded_external_tenant_ids
          }
        }
      }
    }
    client_applications {
      included_service_principals = local.sps.included
      excluded_service_principals = local.sps.excluded
    }
    locations {
      included_locations = var.included_location_ids
      excluded_locations = var.excluded_location_ids
    }
    platforms {
      included_platforms = var.included_platforms
      excluded_platforms = local.excluded_platforms
    }
    dynamic "devices" {
      for_each = null == null ? [] : []
      content {
        filter {
          mode = null
          rule = null
        }
      }
    }
  }
  grant_controls {
    built_in_controls                 = var.grant_controls
    operator                          = local.grant_or
    authentication_strength_policy_id = var.authentication_strength_policy_id
    custom_authentication_factors     = null #to-do var.custom_authentication_factors
    terms_of_use                      = null #to-do var.terms_of_use
  }
  session_controls {
    persistent_browser_mode                   = var.persistent_browser_mode
    application_enforced_restrictions_enabled = var.app_restrictions
    disable_resilience_defaults               = var.disable_resilience_defaults
    sign_in_frequency                         = var.sign_in_frequency
    sign_in_frequency_period                  = local.by_hour
    sign_in_frequency_authentication_type     = var.sign_in_frequency_auth_type
    sign_in_frequency_interval                = var.frequency_interval
    cloud_app_security_policy                 = var.cloud_app_security_policy
  }
}
resource "azuread_group" "example" {
  display_name     = local.group_name
  security_enabled = true
  description = local.group_description
}