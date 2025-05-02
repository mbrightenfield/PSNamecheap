<#
.SYNOPSIS
Renews an expiring domain

.DESCRIPTION
Renews an expiring domain via Namecheaps API command namecheap.domains.renew

.PARAMETER DomainName
The Domain Name to renew

.PARAMETER Years
Number of years to renew

.PARAMETER PromotionCode
Promotional (coupon) code for renewing the domain

.PARAMETER IsPremiumDomain
Indication if the domain name is premium

.PARAMETER PremiumPrice
Renewal price for the premium domain

.EXAMPLE
domains.renew -DomainName "example.com" -Years 1

.LINK
https://www.namecheap.com/support/api/methods/domains/renew/
#>
function domains.renew{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateLength(0,70)]
        [string] $DomainName,

        [Parameter(Mandatory=$true, Position=1)]
        [ValidateRange(0,99)]
        [int] $Years,

        [Parameter(Mandatory=$false, Position=2)]
        [ValidateLength(0,20)]
        [string] $PromotionCode,

        [Parameter(Mandatory=$false, Position=3)]
        [boolean] $IsPremiumDomain,

        [Parameter(Mandatory=$false, Position=4)]
        [double] $PremiumPrice
    )

    Write-Verbose "domains.renew: ${DomainName} ${Years} years"

    $request = @{
        Command = "namecheap.domains.renew"
        DomainName = $DomainName
        Years = $Years
        PromotionCode = $PromotionCode
        IsPremiumDomain = $IsPremiumDomain
        PremiumPrice = $PremiumPrice
    }


    (api.request $request).DomainRenewResult
}