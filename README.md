# terraform-azuread-cap

## Entra Conditional Access

Author: Cole Heard

Version: 0.5.0

## Description

This module creates a Conditional Access policy.

<!-- BEGIN_TF_DOCS -->
#### Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >=2.46.0 |

#### Resources

| Name | Type |
|------|------|
| [azuread_conditional_access_policy.policy](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/conditional_access_policy) | resource |
| [azuread_group.example](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azuread_application.excluded_apps](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application) | data source |
| [azuread_application.included_apps](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application) | data source |
| [azuread_groups.excluded_groups](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/groups) | data source |
| [azuread_groups.included_groups](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/groups) | data source |
| [azuread_service_principals.excluded_sps](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principals) | data source |
| [azuread_service_principals.included_sps](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principals) | data source |
| [azuread_users.excluded_users](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/users) | data source |
| [azuread_users.included_users](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/users) | data source |

## Example Usage:
```hcl
module "example" {

	 # Required Input
	 source  =
	 version  =
	 grant_controls  = 

	 # Optional Input
	 app_restrictions  =
	 authentication_strength_policy_id  =
	 client_app_types  =
	 cloud_app_security_policy  =
	 con_name_override  =
	 custom_authentication_factors  =
	 disable_resilience_defaults  =
	 excluded_apps  =
	 excluded_external_membertypes  =
	 excluded_external_tenant_ids  =
	 excluded_groups  =
	 excluded_location_ids  =
	 excluded_platforms  =
	 excluded_sps  =
	 excluded_users  =
	 frequency_interval  =
	 grant_or  =
	 included_apps  =
	 included_external_membertypes  =
	 included_external_tenant_ids  =
	 included_groups  =
	 included_location_ids  =
	 included_platforms  =
	 included_sps  =
	 included_users  =
	 persistent_browser_mode  =
	 response_name_override  =
	 sign_in_frequency  =
	 sign_in_frequency_auth_type  =
	 sign_in_frequency_by_hours  =
	 signin_risk  =
	 sps_risk  =
	 state  =
	 target_name_override  =
	 terms_of_use  =
	 user_risk  =
}
```

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_restrictions"></a> [app\_restrictions](#input\_app\_restrictions) | If true, enables the application\_enforced\_restrictions\_enabled parameter for Office 365, Exchange Online and Sharepoint Online. | `bool` | `false` | no |
| <a name="input_authentication_strength_policy_id"></a> [authentication\_strength\_policy\_id](#input\_authentication\_strength\_policy\_id) | This input accepts object IDs of authentication strength policies and passes them to the module's CA policy. | `string` | `null` | no |
| <a name="input_client_app_types"></a> [client\_app\_types](#input\_client\_app\_types) | Software the user is employing for access. | `list(string)` | ```[ "all" ]``` | no |
| <a name="input_cloud_app_security_policy"></a> [cloud\_app\_security\_policy](#input\_cloud\_app\_security\_policy) | Specifies the cloud app security policy. Possible values are: blockDownloads, mcasConfigured, monitorOnly, or unknownFutureValue. | `string` | `"monitorOnly"` | no |
| <a name="input_con_name_override"></a> [con\_name\_override](#input\_con\_name\_override) | Overrides the condition portion of the policy naming scheme. | `string` | `null` | no |
| <a name="input_custom_authentication_factors"></a> [custom\_authentication\_factors](#input\_custom\_authentication\_factors) | This input accepts IDs of custom authentication factors and passes them to the policy. | `string` | `null` | no |
| <a name="input_disable_resilience_defaults"></a> [disable\_resilience\_defaults](#input\_disable\_resilience\_defaults) | If true, resiliance defaults will be disabled for this policy. | `bool` | `false` | no |
| <a name="input_excluded_apps"></a> [excluded\_apps](#input\_excluded\_apps) | Enterprise applications excluded by this policy. | `list(string)` | ```[ "None" ]``` | no |
| <a name="input_excluded_external_membertypes"></a> [excluded\_external\_membertypes](#input\_excluded\_external\_membertypes) | The policy will enforce if the sign-in comes from the listed device platform(s). | `list(string)` | ```[ "none" ]``` | no |
| <a name="input_excluded_external_tenant_ids"></a> [excluded\_external\_tenant\_ids](#input\_excluded\_external\_tenant\_ids) | A list of external tenant ids to exclude from the policy. Only functional when used with var.excluded\_external\_membertypes. | `list(string)` | ```[ "none" ]``` | no |
| <a name="input_excluded_groups"></a> [excluded\_groups](#input\_excluded\_groups) | The group(s) excluded to this policy. | `list(string)` | ```[ "None" ]``` | no |
| <a name="input_excluded_location_ids"></a> [excluded\_location\_ids](#input\_excluded\_location\_ids) | A list of Named Location IDs that will be excluded from the policy. | `list(string)` | ```[ "None" ]``` | no |
| <a name="input_excluded_platforms"></a> [excluded\_platforms](#input\_excluded\_platforms) | The policy will enforce if the sign-in comes from the listed device platform(s). | `list(string)` | ```[ "none" ]``` | no |
| <a name="input_excluded_sps"></a> [excluded\_sps](#input\_excluded\_sps) | A list of Service Principals explicitly exluded from this policy. | `list(string)` | ```[ "None" ]``` | no |
| <a name="input_excluded_users"></a> [excluded\_users](#input\_excluded\_users) | A list of UPNs explicitly exluded from this policy. | `list(string)` | ```[ "None" ]``` | no |
| <a name="input_frequency_interval"></a> [frequency\_interval](#input\_frequency\_interval) | Sets persistent\_browser\_mode. | `string` | `"timeBased"` | no |
| <a name="input_grant_controls"></a> [grant\_controls](#input\_grant\_controls) | A list of selected grant controls. Also see var.grant\_control\_or. | `list(string)` | n/a | yes |
| <a name="input_grant_or"></a> [grant\_or](#input\_grant\_or) | If true, evaluates the grant\_controls with an OR operator instead of an AND. | `bool` | `false` | no |
| <a name="input_included_apps"></a> [included\_apps](#input\_included\_apps) | Enterprise applications targeted by this policy. | `list(string)` | ```[ "All" ]``` | no |
| <a name="input_included_external_membertypes"></a> [included\_external\_membertypes](#input\_included\_external\_membertypes) | The policy will enforce if the sign-in comes from the listed device platform(s). | `list(string)` | ```[ "none" ]``` | no |
| <a name="input_included_external_tenant_ids"></a> [included\_external\_tenant\_ids](#input\_included\_external\_tenant\_ids) | A list of external tenant ids to included in this policy. Only functional when used with var.included\_external\_membertypes. | `list(string)` | ```[ "none" ]``` | no |
| <a name="input_included_groups"></a> [included\_groups](#input\_included\_groups) | The group(s) assigned to this policy. | `list(string)` | ```[ "None" ]``` | no |
| <a name="input_included_location_ids"></a> [included\_location\_ids](#input\_included\_location\_ids) | A list of Named Location IDs that will this policy will apply against. | `list(string)` | ```[ "All" ]``` | no |
| <a name="input_included_platforms"></a> [included\_platforms](#input\_included\_platforms) | The policy will enforce if the sign-in comes from the listed device platform(s). | `list(string)` | ```[ "all" ]``` | no |
| <a name="input_included_sps"></a> [included\_sps](#input\_included\_sps) | A list of Service Principals explicitly assigned to this policy. | `list(string)` | ```[ "None" ]``` | no |
| <a name="input_included_users"></a> [included\_users](#input\_included\_users) | A list of UPNs explicitly assigned to this policy. | `list(string)` | ```[ "All" ]``` | no |
| <a name="input_persistent_browser_mode"></a> [persistent\_browser\_mode](#input\_persistent\_browser\_mode) | Sets persistent\_browser\_mode. | `string` | `"always"` | no |
| <a name="input_response_name_override"></a> [response\_name\_override](#input\_response\_name\_override) | Overrides the response portion of the policy naming scheme. | `string` | `null` | no |
| <a name="input_sign_in_frequency"></a> [sign\_in\_frequency](#input\_sign\_in\_frequency) | The number of VMs requested for this pool. | `number` | `3` | no |
| <a name="input_sign_in_frequency_auth_type"></a> [sign\_in\_frequency\_auth\_type](#input\_sign\_in\_frequency\_auth\_type) | Sets if the policy is enabled, disabled, or in a reportonly mode. | `string` | `"primaryAndSecondaryAuthentication"` | no |
| <a name="input_sign_in_frequency_by_hours"></a> [sign\_in\_frequency\_by\_hours](#input\_sign\_in\_frequency\_by\_hours) | If true, the sign-in frequency will evaluate by hours intead of by days. | `bool` | `false` | no |
| <a name="input_signin_risk"></a> [signin\_risk](#input\_signin\_risk) | Configured sign-in risk level for the policy to be enforced. | `list(string)` | ```[ "none" ]``` | no |
| <a name="input_sps_risk"></a> [sps\_risk](#input\_sps\_risk) | Configured Service Principals risk level for the policy to be enforced. | `list(string)` | ```[ "none" ]``` | no |
| <a name="input_state"></a> [state](#input\_state) | Sets if the policy is enabled, disabled, or in a reportonly mode. | `string` | `"reportonly"` | no |
| <a name="input_target_name_override"></a> [target\_name\_override](#input\_target\_name\_override) | Overrides the target portion of the policy naming scheme. | `string` | `null` | no |
| <a name="input_terms_of_use"></a> [terms\_of\_use](#input\_terms\_of\_use) | This input accepts terms\_of\_use object IDs and passes them to the policy. | `string` | `null` | no |
| <a name="input_user_risk"></a> [user\_risk](#input\_user\_risk) | Configured user risk level for the policy to be enforced. | `list(string)` | ```[ "none" ]``` | no |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_group_name"></a> [group\_name](#output\_group\_name) | n/a |
| <a name="output_policy_name"></a> [policy\_name](#output\_policy\_name) | ##>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<### ## Output ##>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<###>-<### |
<!-- END_TF_DOCS -->

## Disclaimer

> See the LICENSE file for all disclaimers. Copyright (c) 2023 Cole Heard