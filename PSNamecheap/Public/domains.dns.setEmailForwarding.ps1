<#
.SYNOPSIS
Sets email forwarding for a domain name

.DESCRIPTION
Sets email forwarding for a domain name via Namecheap API command namecheap.domains.dns.setEmailForwarding

.PARAMETER DomainName
Domain name to set settings

.PARAMETER Forwards
An array of Hashtable or PSCustomObjects containing mailbox forwarding records.  Each record should contain the following properties:
MailBox - MailBox for which you wish to set email forwarding. For example: example@namecheap.com
ForwardTo - Email address to forward to. For example: example@gmail.com

.EXAMPLE
domains.dns.setEmailForwarding -DomaindName "example.com" -Forwards @(@{MailBox="example@example.com"; ForwardTo="example@gmail.com"})

.LINK
https://www.namecheap.com/support/api/methods/domains-dns/set-email-forwarding/
#>
function domains.dns.setEmailForwarding {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateLength(0,70)]
        [string] $DomainName,

        [Parameter(Mandatory=$true, Position=1)]
        [System.Object[]] $Forwards
    )

    Write-Verbose "domains.dns.setEmailForwarding: ${DomainName}"

    $request = @{
        Command = "namecheap.domains.dns.setEmailForwarding"
        DomainName = $DomainName
    }

    # Append mailbox forwards to request (MailBox[1..n], ForwardTo[1..n])
    for($i = 0; $i -lt $Forwards.Count; $i++){
        $num = $i + 1

        switch ($Forwards[$i].GetType().Name) {
            {($_ -eq "Hashtable") -or ($_ -eq "OrderedDictionary")} {
                foreach($key in $Forwards[$i].Keys){
                    $request["${key}${num}"] = $Forwards[$i].$key
                }
                break
            }

            "PSCustomObject" {
                foreach($prop in $Forwards[$i].PSObject.Properties){
                    $request["$($prop.Name)${num}"] = $prop.Value
                }
                break
            }

            default {
                throw "Unsupported Record Type '$($Forwards[$i].GetType().Name)'.  Expected Hashtable or PSCustomObject"
            }
        }
    }

    Write-Debug ($request | ConvertTo-Json -Depth 10)

    (api.request -Params $request -Method POST).DomainDNSSetEmailForwardingResult
}