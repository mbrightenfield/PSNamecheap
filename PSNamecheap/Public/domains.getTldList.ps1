<#
.SYNOPSIS
Returns a list of TLDs

.DESCRIPTION
Returns a list of TLDs via Namecheap API command namecheap.domains.getTldList

.EXAMPLE
$tlds = domains.getTldList
$tlds | Format-Table -AutoSize

.NOTES
We strongly recommend that you cache this API response to avoid repeated calls.

.LINK
https://www.namecheap.com/support/api/methods/domains/get-tld-list/
#>
function domains.getTldList{
    [CmdletBinding()]
    param()

    Write-Verbose "domains.getTldList"

    (api.request @{Command = "namecheap.domains.getTldList"}).Tlds.Tld
}