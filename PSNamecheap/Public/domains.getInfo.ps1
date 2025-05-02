<#
.SYNOPSIS
Returns information about the requested domain

.DESCRIPTION
Returns information about the requested domain

.PARAMETER DomainName
Domain name for which domain information needs to be requested

.PARAMETER HostName
Hosted domain name for which domain information needs to be requested

.EXAMPLE
domains.getInfo -DomainName "example.com"

.LINK
https://www.namecheap.com/support/api/methods/domains/get-info/
#>
function domains.getInfo{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateLength(0,70)]
        [string] $DomainName,

        [Parameter(Mandatory=$false, Position=1)]
        [ValidateLength(0,255)]
        [string] $HostName
    )

    Write-Verbose "domains.getInfo: DomainName = ${DomainName}, HostName = ${HostName}"

    $request = @{
        Command = "namecheap.domains.getInfo"
        DomainName = $DomainName
        HostName = $HostName
    }

    (api.request $request).DomainGetInfoResult
}