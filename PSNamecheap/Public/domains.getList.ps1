<#
.SYNOPSIS
Returns a list of domains for the particular user

.DESCRIPTION
Returns a list of domains for the particular user via Namecheap API command namecheap.domains.getList

.PARAMETER ListType
Possible values are ALL, EXPIRING, or EXPIRED. Default Value: ALL

.PARAMETER SearchTerm
Keyword to look for in the domain list

.PARAMETER Page
Page to return. Default Value: 1

.PARAMETER PageSize
Number of domains to be listed on a page. Minimum value is 10, and maximum value is 100.

.PARAMETER SortBy
Possible values are NAME, NAME_DESC, EXPIREDATE, EXPIREDATE_DESC, CREATEDATE, CREATEDATE_DESC

.EXAMPLE
$domains = domains.getList
$domains.Paging | Format-Table -AutoSize
$domains.DomainGetListResult.Domain | Format-Table -AutoSize

.EXAMPLE
domains.getList -ListType "Expiring" -SearchTerm ".com"

.LINK
https://www.namecheap.com/support/api/methods/domains/get-list/
#>
function domains.getList{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false, Position=0)]
        [ValidateSet("ALL", "EXPIRING", "EXPIRED")]
        [ValidateLength(0,10)]
        [PSDefaultValue(Help = "ALL")]
        [string] $ListType = "ALL",

        [Parameter(Mandatory=$false, Position=1)]
        [ValidateLength(0,70)]
        [string] $SearchTerm = $null,

        [Parameter(Mandatory=$false, Position=2)]
        [PSDefaultValue(Help = "1")]
        [Int] $Page = 1,

        [Parameter(Mandatory=$false, Position=3)]
        [ValidateRange(10,100)]
        [PSDefaultValue(Help = "100")]
        [Int] $PageSize = 100,

        [Parameter(Mandatory=$false, Position=4)]
        [ValidateSet("NAME", "NAME_DESC", "EXPIREDATE", "EXPIREDATE_DESC", "CREATEDATE", "CREATEDATE_DESC")]
        [ValidateLength(0,50)]
        [PSDefaultValue(Help = "NAME")]
        [string] $SortBy = "NAME"
    )

    Write-Verbose "domains.getList: ListType: ${ListType}, SearchTerm: ${SearchTerm}, Page: ${Page}, PageSize: ${PageSize}, SortBy: ${SortBy}"

    $params = @{
        Command = "namecheap.domains.getList"
        ListType = $ListType
        SearchTerm = $SearchTerm
        Page = $Page
        PageSize = $PageSize
        SortBy = $SortBy
    }

    #$request = API_Request $params

    #$request.ApiResponse.CommandResponse.DomainGetListResult.Domain

    api.request $params
}