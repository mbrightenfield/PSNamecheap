<#
.SYNOPSIS
Sets domain to use custom DNS servers.

.DESCRIPTION
Sets domain to use custom DNS servers via Namecheap API command namecheap.domains.dns.setCustom

.PARAMETER DomainName
The domain name to set custom name servers for

.PARAMETER Nameservers
A comma-separated list of name servers to be associated with this domain

.EXAMPLE
domains.dns.setCustom -DomainName "example.com" -Nameservers "dns1.name-servers.com,dns2.nameservers.com"

.LINK
https://www.namecheap.com/support/api/methods/domains-dns/set-custom/
#>
function domains.dns.setCustom {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string] $DomainName,

        [Parameter(Mandatory=$true, Position=1)]
        [ValidateLength(0,1200)]
        [string] $Nameservers
    )

    $domain = DomainSplit $DomainName
    $SLD = $domain.SLD
    $TLD = $domain.TLD

    Write-Verbose "domains.dns.setCustom: ${SLD}.${TLD}"

    $request = @{
        Command = "namecheap.domains.dns.setCustom"
        SLD = $SLD
        TLD = $TLD
        Nameservers = $Nameservers
    }

    (api.request $request).DomainDNSSetCustomResult
}