<#
.SYNOPSIS
Sets DNS host records settings for the requested domain.

.DESCRIPTION
Sets DNS host records settings for the requested domain.

.PARAMETER DomainName
The domain to setHosts in the format "<SLD>.<TLD>"

.PARAMETER Records
An array of DNS host records (Hashtable or PSCustomObject) to set for the domain. Each record should contain the following keys/properties:

HostName - Sub-domain/hostname to create the record for
RecordType - Possible values: A, AAAA, ALIAS, CAA, CNAME, MX, MXE, NS, TXT, URL, URL301, FRAME
Address - Possible values are URL or IP address. The value for this parameter is based on RecordType.
MXPref - MX preference for host. Applicable for MX records only.
TTL - Time to live for all record types. Possible values: any value between 60 to 60000. Default Value: 1800

.PARAMETER EmailType
Possible values are:
MXE - to set up your custom MXE record.
MX - to set up custom MX records of your mail provider.
FWD - to set up MX records for our Free Email Forwarding service.
OX - to set up MX records for our Private Email service.

.PARAMETER Flag
Is an unsigned integer between 0 and 255. The flag value is an 8-bit number, the most significant bit of which indicates the criticality of understanding of a record by a CA. It's recommended to use '0'

.PARAMETER Tag
A non-zero sequence of US-ASCII letters and numbers in lower case. The tag value can be one of the following values:
issue - specifies the certification authority that is authorized to issue a certificate for the domain name or subdomain record used in the title.
issuewild - specifies the certification authority that is allowed to issue a wildcard certificate for the domain name or subdomain record used in the title. The certificate applies to the domain name or subdomain directly and to all its subdomains.
iodef - specifies the e-mail address or URL (compliant with RFC 5070) a CA should use to notify a client if any issuance policy violation spotted by this CA.

.EXAMPLE
$hosts = @(
    [ordered]@{HostName = "@"; RecordType = "A"; Address = "192.168.0.1"; TTL = "3600"}
    [ordered]@{HostName = "www"; RecordType = "CNAME"; Address = "example.com"; TTL = "3600"}
)

domains.dns.setHosts -DomainName "example.com" -Records $hosts -EmailType "FWD"

.LINK
https://www.namecheap.com/support/api/methods/domains-dns/set-hosts/
#>
function domains.dns.setHosts{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string] $DomainName,

        [Parameter(Mandatory=$true, Position=1)]
        [System.Object[]] $Records,

        [Parameter(Mandatory=$true, Position=2)]
        [ValidateSet("MXE", "MX", "FWD", "OX")]
        [string] $EmailType,

        [Parameter(Mandatory=$false, Position=3)]
        [ValidateRange(0,255)]
        [int] $Flag = $null,

        [Parameter(Mandatory=$false, Position=4)]
        [string] $Tag = $null
    )

    $domain = DomainSplit $DomainName
    $request = [ordered]@{
        Command = "namecheap.domains.dns.setHosts"
        SLD = $domain.SLD
        TLD = $domain.TLD
        EmailType = $EmailType
    }

    Write-Verbose "domains.dns.setHosts: $($domain.SLD).$($domain.TLD)"
    Write-Debug "Input Records"
    Write-Debug ($Records | ConvertTo-Json -Depth 10)

    # Append each record's key/value pair to the main request as a numbered key.  Ex. key[1..n] = value
    for($i = 0; $i -lt $Records.Count; $i++){
        $num = $i + 1

        switch ($Records[$i].GetType().Name) {
            {($_ -eq "Hashtable") -or ($_ -eq "OrderedDictionary")} {
                foreach($key in $Records[$i].Keys){
                    $request["${key}${num}"] = $Records[$i].$key
                }
                break
            }

            "PSCustomObject" {
                foreach($prop in $Records[$i].PSObject.Properties){
                    $request["$($prop.Name)${num}"] = $prop.Value
                }
                break
            }

            default {
                throw "Unsupported Record Type '$($Records[$i].GetType().Name)'.  Expected Hashtable or PSCustomObject"
            }
        }
    }

    if($null -ne $Flag){
        $request["Flag"] = $Flag
    }

    if($null -ne $Tag){
        $request["Tag"] = $Tag
    }

    Write-Debug ($request | ConvertTo-Json -Depth 10)

    (api.request -Params $request -Method POST).DomainDNSSetHostsResult
}