<#
.SYNOPSIS
Gets users external IP address via 3rd party IP checker

.DESCRIPTION
Gets user's external IP address via 3rd party IP checker that supports returning just an IP address in the response content when requested from curl.

.PARAMETER ServiceURL
The 3rd party service to use to retrieve your external address from. Default: https://ip.me/

.EXAMPLE
$ip = Get-ClientIP
$ip.IPAddresToString

.OUTPUTS
IPAddress Object
#>
function Get-ClientIP {
    [CmdletBinding()]
    [OutputType([IPAddress])]
    param(
        [Parameter(Mandatory=$false, Position=0)]
        [string] $ServiceURL = "https://ip.me/"
    )

    Write-Verbose "Getting External IP Address from ${ServiceURL}"
    $request = Invoke-WebRequest -Uri $ServiceURL -UserAgent "curl"

    [IPAddress] $request.Content.Trim()
}