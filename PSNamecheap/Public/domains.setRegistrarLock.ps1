<#
.SYNOPSIS
Sets the Registrar Lock status for a domain

.DESCRIPTION
Sets the Registrar Lock status for a domain

.PARAMETER DomainName
Domain name to set status for

.PARAMETER LockAction
Possible values: LOCK, UNLOCK. Default Value: LOCK.

.EXAMPLE
domains.setRegistrarLock -DomainName "example.com" -LockAction UNLOCK

.EXAMPLE
domains.setRegistrarLock example.com LOCK

.LINK
https://www.namecheap.com/support/api/methods/domains/set-registrar-lock/
#>
function domains.setRegistrarLock{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateLength(0,70)]
        [string] $DomainName,

        [Parameter(Mandatory=$false, Position=1)]
        [ValidateLength(0,70)]
        [ValidateSet("LOCK", "UNLOCK")]
        [PSDefaultValue(Help = "LOCK")]
        [string] $LockAction = "LOCK"
    )

    Write-Verbose "domains.setRegistrationLock: ${DomainName} ${LockAction}"

    $request = @{
        Command = "namecheap.domains.setRegistrarLock"
        DomainName = $DomainName
        LockAction = $LockAction
    }

    (api.request $request).DomainSetRegistrarLockResult
}