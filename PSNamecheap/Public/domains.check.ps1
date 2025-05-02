<#
.SYNOPSIS
Checks the availability of domains

.DESCRIPTION
Checks the availability of domains via Namecheap API command namecheap.domains.check

.PARAMETER DomainList
Comma-separated list of domains to check

.EXAMPLE
domains.check -DomainList "example1.com,example2.com,example3.com"

.LINK
https://www.namecheap.com/support/api/methods/domains/check/
#>
function domains.check{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string] $DomainList
    )

    Write-Verbose "domains.check: $DomainList"

    (api.request @{Command = "namecheap.domains.check"; DomainList = $DomainList;}).DomainCheckResult
}