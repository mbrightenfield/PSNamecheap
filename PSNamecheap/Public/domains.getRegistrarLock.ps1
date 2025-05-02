<#
.SYNOPSIS
Gets the Registrar Lock status for the requested domain

.DESCRIPTION
Gets the Registrar Lock status for the requested domain via Namecheap API command namecheap.domains.getRegistrarLock

.PARAMETER DomainName
Domain name to get status for

.EXAMPLE
domains.getRegistrarLock -DomainName "example.com"

.EXAMPLE
domains.getRegistrarLock example.com

.LINK
https://www.namecheap.com/support/api/methods/domains/get-registrar-lock/
#>
function domains.getRegistrarLock{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string] $DomainName
    )

    Write-Verbose "domains.getRegistrarLock: ${DomainName}"

    $request = @{
        Command = "namecheap.domains.getRegistrarLock"
        DomainName = $DomainName
    }

    (api.request $request).DomainGetRegistrarLockResult
}