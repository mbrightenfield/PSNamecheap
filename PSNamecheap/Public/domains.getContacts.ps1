<#
.SYNOPSIS
Gets contact information for the requested domain

.DESCRIPTION
namecheap.domains.getContacts - Gets contact information for the requested domain

.PARAMETER DomainName
Domain to get contacts for

.EXAMPLE
domains.getContacts -DomainName "example.com"

.EXAMPLE
domains.getContacts "example.com"

.LINK
https://www.namecheap.com/support/api/methods/domains/get-contacts/
#>
function domains.getContacts {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateLength(0,70)]
        [string] $DomainName
    )

    Write-Verbose "domains.getContacts: ${DomainName}"

    api.request @{Command = "namecheap.domains.getContacts"; DomainName = $DomainName}
}