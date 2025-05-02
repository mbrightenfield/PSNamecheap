<#
.SYNOPSIS
Retrieves DNS host record settings for the requested domain.

.DESCRIPTION
Retrieves DNS host record settings for the requested domain via Namecheap API command namecheap.domains.dns.getHosts

.PARAMETER DomainName
The full domain in the format SLD.TLD
Should not be used if specifying SLD and TLD parameters explicitly.

.EXAMPLE
domains.dns.getHosts "example.com"

.EXAMPLE
domains.dns.getHosts -SLD "example" -TLD "com"

.LINK
https://www.namecheap.com/support/api/methods/domains-dns/get-hosts/
#>
function domains.dns.getHosts {
[CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string] $DomainName
    )

    $domain = DomainSplit $DomainName
    $SLD = $domain.SLD
    $TLD = $domain.TLD

    Write-Verbose "domains.dns.getHosts: ${SLD}.${TLD}"

    $request = @{
        Command = "namecheap.domains.dns.getHosts"
        SLD = $SLD
        TLD = $TLD
    }

    (api.request $request).DomainDNSGetHostsResult
}