<#
.SYNOPSIS
Builds config file for Namecheap API credentials and then calls api.config.load.

.DESCRIPTION
Builds a JSON config file with ApiURL, ApiUser, UserName, and ApiKey properties. The users and ApiKey are stored as SecureStrings.
Config filename format: PSNamecheap.config.${env:ComputerName}.${env:UserName}.json

.PARAMETER api
(Optional) The API URL to use. Defaults to https://api.sandbox.namecheap.com/xml.response

.PARAMETER path
(Optional) The path to the API Credential file to load.

.PARAMETER DifferentUserName
(Optional) If the ApiUser and UserName Global Parameters are different, set DiffernetUserName to $true.
Default operation is make the UserName value the same as ApiUser.
Default: $false

.EXAMPLE
api.config.build -api "https://api.sandbox.namecheap.com/xml.response" -path "/path/to/config.json"

.EXAMPLE
api.config.build

#>
function api.config.build{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [string] $api = "https://api.sandbox.namecheap.com/xml.response",

        [Parameter(Mandatory=$false)]
        [string] $path = $default_config_path,

        [Parameter(Mandatory=$false)]
        [switch] $DifferentUserName = $false
    )

    Write-Verbose "api.config.build: api: ${api} path: ${path}"

    Write-Verbose "Requesting Namecheap API Credentials"

    # Prompt for ApiUser
    Write-Output "Enter ApiUser:"
    $api_user = Read-Host -AsSecureString

    # Prompt for UserName
    if($DifferentUserName -eq $true){
        Write-Output "Enter UserName:"
        $user_name = Read-Host -AsSecureString
    }
    else{
        $user_name = $api_user
    }

    # Prompt for ApiKey
    Write-Output "Enter ApiKey:"
    $api_key = Read-Host -AsSecureString

    # Prompt for ClientIP
    try{
        $ip = Get-ClientIP
        $client_ip = $ip.IPAddressToString
    }
    catch {
        Write-Output "Failed to retrieve external IP Address automatically.  Enter ClientIP manually."
        Write-Output "Enter ClientIP:"
        $client_ip = Read-Host
    }

    # Prepare Config
    $config_data = [ordered]@{
        ApiUrl = $api
        Global = [ordered]@{
            ApiUser = ConvertFrom-SecureString -SecureString $api_user
            UserName = ConvertFrom-SecureString -SecureString $user_name
            ApiKey = ConvertFrom-SecureString -SecureString $api_key
            ClientIp = $client_ip
        }
    }

    Write-Debug ($config_data | ConvertTo-Json)

    # Write Confing to file
    $config_data | ConvertTo-Json | Out-File -FilePath $path -Confirm

    # Must reload the config data into the module after written to file.
    api.config.load -path $path
}