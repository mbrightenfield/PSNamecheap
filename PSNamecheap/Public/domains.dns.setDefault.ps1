<#
.SYNOPSIS
Sets domain to use our default DNS servers.

.DESCRIPTION
Sets domain to use our default DNS servers. Required for free services like Host record management, URL forwarding, email forwarding, dynamic dns and other value added services.

.PARAMETER DomainName
Domain to set default DNS server for.

.EXAMPLE
domains.dns.setDefault -DomainName "example.com"

.LINK
https://www.namecheap.com/support/api/methods/domains-dns/set-default/
#>
function domains.dns.setDefault{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string] $DomainName
    )

    $domain = DomainSplit $DomainName
    $SLD = $domain.SLD
    $TLD = $domain.TLD

    Write-Verbose "domains.dns.setDefault: ${SLD}.${TLD}"

    $request = @{
        Command = "namecheap.domains.dns.setDefault"
        SLD = $SLD
        TLD = $TLD
    }

    (api.request $request).DomainDNSSetDefaultResult
}