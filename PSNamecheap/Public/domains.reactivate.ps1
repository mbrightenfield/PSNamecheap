<#
.SYNOPSIS
Reactivates an expired domain

.DESCRIPTION
Reactivates an expired domain via Namecheap API command namecheap.domains.reactivate

.PARAMETER DomainName
Domain name to reactivate

.PARAMETER PromotionCode
Promotional (coupon) code for reactivating the domain

.PARAMETER YearsToAdd
Number of years after expiry

.PARAMETER IsPremiumDomain
Indication if the domain name is premium

.PARAMETER PremiumPrice
Reactivation price for the premium domain

.EXAMPLE
domains.reactivate -DomainName "example.com" -YearstoAdd 1

.LINK
https://www.namecheap.com/support/api/methods/domains/reactivate/
#>
function domains.reactivate{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateLength(0,70)]
        [string] $DomainName,

        [Parameter(Mandatory=$false, Position=1)]
        [ValidateLength(0,70)]
        [string] $PromotionCode,

        [Parameter(Mandatory=$false, Position=2)]
        [ValidateRange(0,99)]
        [int] $YearsToAdd,

        [Parameter(Mandatory=$false, Position=3)]
        [boolean] $IsPremiumDomain,

        [Parameter(Mandatory=$false, Position=4)]
        [double] $PremiumPrice
    )

    Write-Verbose "domains.reactivate: ${DomainName}"

    $request = @{
        Command = "namecheap.domains.reactivate"
        DomainName = $DomainName
        PromotionCode = $PromotionCode
        YearsToAdd = $YearsToAdd
        IsPremiumDomain = $IsPremiumDomain
        PremiumPrice = $PremiumPrice
    }

    (api.request $request).DomainRactivateResult
}