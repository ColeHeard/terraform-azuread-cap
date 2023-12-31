###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###
### Variables - Required - Access Control
###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###
variable "grant_controls" {
  type        = list(string)
  description = "A list of selected grant controls. Also see var.grant_control_or."
  validation {
    condition = alltrue([
      for i in var.grant_controls : anytrue([
        i == "block",
        i == "mfa",
        i == "approvedApplication",
        i == "compliantApplication",
        i == "compliantDevice",
        i == "domainJoinedDevice",
        i == "passwordChange",
        i == "unknownFutureValue"
      ])
    ])
    error_message = "Invalid input for grant_control_list. The list may only contain: block, mfa, approvedApplication, compliantApplication, compliantDevice, domainJoinedDevice, passwordChange, or unknownFutureValue."
  }
}
###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###
### Variables - Optional - Access Control
###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###
variable "grant_or" {
  type        = bool
  description = "If true, evaluates the grant_controls with an OR operator instead of an AND."
  default     = false
}
variable "app_restrictions" {
  type        = bool
  description = "If true, enables the application_enforced_restrictions_enabled parameter for Office 365, Exchange Online and Sharepoint Online."
  default     = false
}
variable "disable_resilience_defaults" {
  type        = bool
  description = "If true, resiliance defaults will be disabled for this policy."
  default     = false
}
### Unsure if list or single selection option! Think single value due to "OR" description. To-do
variable "cloud_app_security_policy" {
  type        = string
  description = "Specifies the cloud app security policy. Possible values are: blockDownloads, mcasConfigured, monitorOnly, or unknownFutureValue."
  default     = "monitorOnly" #to-do null logic
  validation {
    condition = anytrue([
      var.cloud_app_security_policy == "blockDownloads",
      var.cloud_app_security_policy == "mcasConfigured",
      var.cloud_app_security_policy == "monitorOnly",
      var.cloud_app_security_policy == "unknownFutureValue"
    ])
    error_message = "Invalid input. The accepted values for cloud_app_security_policy are: blockDownloads, mcasConfigured, monitorOnly, or unknownFutureValue."
  }
}
variable "sign_in_frequency" {
  type        = number
  description = "The number of VMs requested for this pool."
  default     = 3
  validation {
    condition = (
      var.sign_in_frequency >= 0 &&
      var.sign_in_frequency <= 90
    )
    error_message = "The selected sign-in frequency for this policy. Choose a value 1 to 90."
  }
}
variable "sign_in_frequency_by_hours" {
  type        = bool
  description = "If true, the sign-in frequency will evaluate by hours intead of by days."
  default     = false
}
variable "frequency_interval" {
  type        = string
  description = "Sets persistent_browser_mode."
  default     = "timeBased"
  validation {
    condition = anytrue([
      var.frequency_interval == "timeBased",
      var.frequency_interval == "everyTime"
    ])
    error_message = "Invalid input for frequency_interval. Accceptable values are: timeBased or everyTime."
  }
}
variable "sign_in_frequency_auth_type" {
  type        = string
  description = "Sets if the policy is enabled, disabled, or in a reportonly mode."
  default     = "primaryAndSecondaryAuthentication"
  validation {
    condition = anytrue([
      var.sign_in_frequency_auth_type == "primaryAndSecondaryAuthentication",
      var.sign_in_frequency_auth_type == "secondaryAuthentication"
    ])
    error_message = "Invalid input for sign_in_frequency_auth_type. Accceptable values are: primaryAndSecondaryAuthentication or secondaryAuthentication."
  }
}
variable "terms_of_use" {
  type        = string
  description = "This input accepts terms_of_use object IDs and passes them to the policy."
  default     = null
}
variable "custom_authentication_factors" {
  type        = string
  description = "This input accepts IDs of custom authentication factors and passes them to the policy."
  default     = null
}
variable "authentication_strength_policy_id" {
  type        = string
  description = "This input accepts object IDs of authentication strength policies and passes them to the module's CA policy."
  default     = null
}
variable "persistent_browser_mode" {
  type        = string
  description = "Sets persistent_browser_mode."
  default     = "always" #to do null logic
  validation {
    condition = anytrue([
      var.persistent_browser_mode == "always",
      var.persistent_browser_mode == "never"
    ])
    error_message = "Invalid input for persistent_browser_mode. Accceptable values are: always or never."
  }
}
###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###
### Variables - Optional - Policy Settings
###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###

variable "state" {
  type        = string
  description = "Sets if the policy is enabled, disabled, or in a reportonly mode."
  default     = "reportonly"
  validation {
    condition = anytrue([
      lower(var.state) == "reportonly",
      lower(var.state) == "enabled",
      lower(var.state) == "disabled"
    ])
    error_message = "Invalid input. The accepted values for state are: reportonly, enabled, or disabled."
  }
}
###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###
### Variables - Optional - Assignments
###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###
variable "included_platforms" {
  type        = list(string)
  description = "The policy will enforce if the sign-in comes from the listed device platform(s)."
  default     = ["all"]
  validation {
    condition = alltrue([
      for i in var.included_platforms : anytrue([
        i == "all",
        i == "android",
        i == "iOS",
        i == "linux",
        i == "macOS",
        i == "windows",
        i == "windowsPhone",
        i == "unknownFutureValue"
      ])
    ])
    error_message = "Invalid input for excluded_platforms. The list may only contain: all, android, iOS, linux, macOS, windows, windowsPhone or unknownFutureValue."
  }
}
variable "excluded_platforms" {
  type        = list(string)
  description = "The policy will enforce if the sign-in comes from the listed device platform(s)."
  default     = ["none"]
  validation {
    condition = alltrue([
      for i in var.excluded_platforms : anytrue([
        i == "none",
        i == "all",
        i == "android",
        i == "iOS",
        i == "linux",
        i == "macOS",
        i == "windows",
        i == "windowsPhone",
        i == "unknownFutureValue"
      ])
    ])
    error_message = "Invalid input for included_platforms. The list may only contain: none, all, android, iOS, linux, macOS, windows, windowsPhone or unknownFutureValue."
  }
}
variable "included_location_ids" {
  type        = list(string)
  description = "A list of Named Location IDs that will this policy will apply against."
  default     = ["All"]
}
variable "excluded_location_ids" {
  type        = list(string)
  description = "A list of Named Location IDs that will be excluded from the policy."
  default     = ["None"]
}
variable "client_app_types" {
  type        = list(string)
  description = "Software the user is employing for access."
  default     = ["all"]
  validation {
    condition = alltrue([
      for i in var.client_app_types : anytrue([
        i == "all",
        i == "browser",
        i == "mobileAppsAndDesktopClients",
        i == "exchangeActiveSync",
        i == "easSupported",
        i == "other"
      ])
    ])
    error_message = "Invalid input for client_app_types. The list may only contain: all, browser, mobileAppsAndDesktopClients, exchangeActiveSync, easSupported, and other."
  }
}
variable "user_risk" {
  type        = list(string)
  description = "Configured user risk level for the policy to be enforced."
  default     = ["none"]
  validation {
    condition = alltrue([
      for i in var.user_risk : anytrue([
        i == "low",
        i == "medium",
        i == "high",
        i == "none",
        i == "hidden",
        i == "unknownFutureValue"
      ])
    ])
    error_message = "Invalid input for user_risk. The list may only contain: low, medium, high, none, hidden, and unknownFutureValue."
  }
}
variable "signin_risk" {
  type        = list(string)
  description = "Configured sign-in risk level for the policy to be enforced."
  default     = ["none"]
  validation {
    condition = alltrue([
      for i in var.signin_risk : anytrue([
        i == "low",
        i == "medium",
        i == "high",
        i == "none",
        i == "hidden",
        i == "unknownFutureValue"
      ])
    ])
    error_message = "Invalid input for signin_risk. The list may only contain: low, medium, high, none, hidden, and unknownFutureValue."
  }
}
variable "sps_risk" {
  type        = list(string)
  description = "Configured Service Principals risk level for the policy to be enforced."
  default     = ["none"]
  validation {
    condition = alltrue([
      for i in var.sps_risk : anytrue([
        i == "low",
        i == "medium",
        i == "high",
        i == "none",
        i == "unknownFutureValue"
      ])
    ])
    error_message = "Invalid input for spsl_risk. The list may only contain: low, medium, high, none, and unknownFutureValue."
  }
}
variable "included_external_membertypes" {
  type        = list(string)
  description = "The policy will enforce if the sign-in comes from the listed device platform(s)."
  default     = ["none"]
  validation {
    condition = alltrue([
      for i in var.included_external_membertypes : anytrue([
        i == "b2bCollaborationGuest",
        i == "b2bCollaborationMember",
        i == "b2bDirectConnectUser",
        i == "internalGuest",
        i == "none",
        i == "otherExternalUser",
        i == "serviceProvider",
        i == "unknownFutureValue"
      ])
    ])
    error_message = "The list may only contain: b2bCollaborationGuest, b2bCollaborationMember, b2bDirectConnectUser, none, internalGuest, otherExternalUser, serviceProvider, or unknownFutureValue."
  }
}
variable "included_external_tenant_ids" {
  type        = list(string)
  description = "A list of external tenant ids to included in this policy. Only functional when used with var.included_external_membertypes."
  default     = ["none"]
}
variable "excluded_external_membertypes" {
  type        = list(string)
  description = "The policy will enforce if the sign-in comes from the listed device platform(s)."
  default     = ["none"]
  validation {
    condition = alltrue([
      for i in var.excluded_external_membertypes : anytrue([
        i == "b2bCollaborationGuest",
        i == "b2bCollaborationMember",
        i == "b2bDirectConnectUser",
        i == "internalGuest",
        i == "none",
        i == "otherExternalUser",
        i == "serviceProvider",
        i == "unknownFutureValue"
      ])
    ])
    error_message = "The list may only contain: b2bCollaborationGuest, b2bCollaborationMember, b2bDirectConnectUser, none, internalGuest, otherExternalUser, serviceProvider, or unknownFutureValue."
  }
}
variable "excluded_external_tenant_ids" {
  type        = list(string)
  description = "A list of external tenant ids to exclude from the policy. Only functional when used with var.excluded_external_membertypes."
  default     = ["none"]
}
###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###
### Variables - Optional - Data Objects
###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###
variable "included_apps" {
  type        = list(string)
  description = "Enterprise applications targeted by this policy."
  default     = ["All"]
}
variable "excluded_apps" {
  type        = list(string)
  description = "Enterprise applications excluded by this policy."
  default     = ["None"]
}
variable "included_groups" {
  type        = list(string)
  description = "The group(s) assigned to this policy."
  default     = ["None"]
}
variable "excluded_groups" {
  type        = list(string)
  description = "The group(s) excluded to this policy."
  default     = ["None"]
}
variable "included_users" {
  type        = list(string)
  description = "A list of UPNs explicitly assigned to this policy."
  default     = ["All"]
}
variable "excluded_users" {
  type        = list(string)
  description = "A list of UPNs explicitly exluded from this policy."
  default     = ["None"]
}
variable "included_sps" {
  type        = list(string)
  description = "A list of Service Principals explicitly assigned to this policy."
  default     = ["None"]
}
variable "excluded_sps" {
  type        = list(string)
  description = "A list of Service Principals explicitly exluded from this policy."
  default     = ["None"]
}
###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###
### Variables - Optional - Naming Overrides
###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###
variable "response_name_override" {
  type        = string
  description = "Overrides the response portion of the policy naming scheme."
  default     = null
}
variable "target_name_override" {
  type        = string
  description = "Overrides the target portion of the policy naming scheme."
  default     = null
}
variable "con_name_override" {
  type        = string
  description = "Overrides the condition portion of the policy naming scheme."
  default     = null
}