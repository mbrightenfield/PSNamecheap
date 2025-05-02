<#
.SYNOPSIS
Gets email forwarding settings for the requested domain.

.DESCRIPTION
Gets email forwarding settings for the requested domain via Namecheap API command namecheap.domains.dns.getEmailForwarding

.PARAMETER DomainName
Domain name to get settings

.EXAMPLE
domains.dns.getEmailForwarding -DomainName "example.com"

.LINK
https://www.namecheap.com/support/api/methods/domains-dns/get-email-forwarding/
#>
function domains.dns.getEmailForwarding {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateLength(0,70)]
        [string] $DomainName
    )

    Write-Verbose "domains.dns.getEmailForwarding: ${DomainName}"

    $request = @{
        Command = "namecheap.domains.dns.getEmailForwarding"
        DomainName = $DomainName
    }

    (api.request $request).DomainDNSGetEmailForwardingResult
}