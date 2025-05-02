<#
.SYNOPSIS
Splits a domain on "." and breaks it into parts.

.DESCRIPTION
Splits a domain on "." and returns an OrderedDictionary with domain parts Host, SLD, TLD

.PARAMETER DomainName
The domain name to parse

.PARAMETER Parts
The number of expected parts to split the domain into. Default 2
2 parts: <SLD>.<TLD>
3 parts: <HOST>.<SLD>.<TLD>

.EXAMPLE
$domain_parts = DomainSplit -DomainName "example.com"
Write-Host "SLD: $($domain_parts.SLD), TLD: $($domain_parts.TLD)"

.NOTES
If breaking a domain into 3 parts, it doesn't support hosts with '.' in the hostname. expects a simple subdomain like hostwithoutperiod.sld.tld.
Will regex this in the future to support these hostnames, if necessary, but at the moment this function is only being used to break domains into 2 parts.
#>
function DomainSplit{
    [CmdletBinding()]
    [OutputType([System.Collections.Specialized.OrderedDictionary])]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string] $DomainName,

        [Parameter(Mandatory=$false, Position=1)]
        [ValidateSet(2,3)]
        [PSDefaultValue(Help = 2)]
        [int] $Parts = 2
    )

    Write-Verbose "Splitting ${DomainName} into ${Parts} parts"

    $split = $DomainName.Split(".")

    if($split.Length -ne $Parts){
        $format = @{
            2 = "<SLD>.<TLD>"
            3 = "<HOST>.<SLD>.<TLD>"
        }
        throw "Unexpected number of domain parts.  Expected ${Parts} '$($format[$Parts])' but got $($split.Length) '${DomainName}'"
    }

    switch($Parts) {
        2 {
            [ordered]@{
                Name = $DomainName
                SLD = $split[0]
                TLD = $split[1]
            }
            break
        }

        3 {
            [ordered]@{
                Name = $DomainName
                Host = $split[0]
                SLD = $split[1]
                TLD = $split[2]
            }
            break
        }
    }
}