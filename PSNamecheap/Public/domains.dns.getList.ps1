<#
.SYNOPSIS
Gets a list of DNS servers associated with the requested domain.

.DESCRIPTION
Gets a list of DNS servers associated with the requested domain.

.PARAMETER DomainName
The full domain in the format SLD.TLD
Should not be used if specifying SLD and TLD parameters explicitly.

.EXAMPLE
domains.dns.getList "example.com"

.EXAMPLE
domains.dns.getList -DomainName "example.com"

.EXAMPLE
domains.dns.getList -SLD "example" -TLD "com"

.NOTES
Can be called by using the DomainName parameter only or the SLD and TLD parameters together.  However, since multiple parameters across
parameter sets cannot share the same position, you can only omit the parameter name when calling the function with the DomainName parameter set.
If you want to use the SLD.TLD parameter set, you will have to explicitly state the parameter names in the function call.
One could address this by accepting a string argument array as a parameter instead of explicitly specifying each parameter.  This would allow you
to determine which path to take based on the number of argumnets but it prevent you from writing detailed documentation for Get-Help commands.

.LINK
https://www.namecheap.com/support/api/methods/domains-dns/get-list/
#>
function domains.dns.getList{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string] $DomainName
    )

    $domain = DomainSplit $DomainName
    $SLD = $domain.SLD
    $TLD = $domain.TLD

    Write-Verbose "domains.dns.getList: ${SLD}.${TLD}"

    $request = @{
        Command = "namecheap.domains.dns.getList"
        SLD = $SLD
        TLD = $TLD
    }

    (api.request $request).DomainDNSGetListResult
}