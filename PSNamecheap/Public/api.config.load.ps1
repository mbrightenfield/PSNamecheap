<#
.SYNOPSIS
Load Namecheap API Credentials from Config File

.DESCRIPTION
Load Namecheap API Credentials from Config File.  The default config file is located at $PSScriptRoot\PSNamecheap.config.${env:ComputerName}.${env:UserName}.json

.PARAMETER path
(Optional) The path to load the config file from, if the default locaiton is undesired.

.EXAMPLE
# Load modules default config (gets called when module is loaded)
api.config.load

.EXAMPLE
api.config.load -path "/path/to/config.json"
#>
function api.config.load{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [string] $path = $default_config_path
    )

    Write-Verbose "Loading Namecheap API Config: ${path}"

    if(Test-Path -Path $path){
        $secure_config = Get-Content -Path $path | ConvertFrom-Json

        $script:config = [ordered]@{
            ApiURL = $secure_config.ApiURL
            Global = [ordered]@{
                ApiUser = [System.Net.NetworkCredential]::new("", ($secure_config.Global.ApiUser | ConvertTo-SecureString)).Password
                UserName = [System.Net.NetworkCredential]::new("", ($secure_config.Global.UserName | ConvertTo-SecureString)).Password
                ApiKey = [System.Net.NetworkCredential]::new("", ($secure_config.Global.ApiKey | ConvertTo-SecureString)).Password
                ClientIp = $secure_config.Global.ClientIP
            }
        }
    }
    else{
        Write-Warning "Config file not found: ${path} If this is your first time running, call api.config.build to generate a config file."
    }
}
