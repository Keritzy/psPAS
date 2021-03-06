﻿function New-PASAccountGroup {
	<#
.SYNOPSIS
Adds a new account group to the Vault

.DESCRIPTION
Defines a new account group in the vault.
The following permissions are required on the safe where the account group will be created:
 - Add Accounts
 - Update Account Content
 - Update Account Properties
  -Create Folders

.PARAMETER GroupName
The name of the group to create

.PARAMETER GroupPlatform
The name of the platform for the group.
The associated platform must be set to "PolicyType=Group"

.PARAMETER Safe
The Safe where the group will be created

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.PARAMETER PVWAAppName
The name of the CyberArk PVWA Virtual Directory.
Defaults to PasswordVault

.EXAMPLE

.INPUTS
All parameters can be piped by property name

.OUTPUTS
None

.NOTES
Minimum version 9.9.5

.LINK

#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$GroupName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$GroupPlatform,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Safe,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[hashtable]$sessionToken,

		[parameter(
			ValueFromPipelinebyPropertyName = $true
		)]
		[Microsoft.PowerShell.Commands.WebRequestSession]$WebSession,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$BaseURI,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$PVWAAppName = "PasswordVault"
	)

	BEGIN {}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$baseURI/$PVWAAppName/API/AccountGroups/"

		#Create body of request
		$body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

		if($PSCmdlet.ShouldProcess($GroupName, "Define New Account Group")) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Headers $sessionToken -WebSession $WebSession

		}

	}#process

	END {}#end

}