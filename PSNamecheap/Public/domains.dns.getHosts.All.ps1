<#
.SYNOPSIS
Retrieves DNS host record settings for all domains.

.DESCRIPTION
Calls domains.getList.All to retrieve all domains in the account and then loops through each domain and calls domains.dns.getHosts
and returns the full list.

.PARAMETER SleepTime
The time to sleep in seconds between API requests.  Default: 0.2

.EXAMPLE
$hosts = domains.dns.getHosts.All
$hosts | Select-Object Domain, EmailType, IsUsingOurDNS -ExpandProperty Host
#>
function domains.dns.getHosts.All {
    [CmdletBinding()]
    [OutputType([System.Object[]])]
    param(
        [Parameter(Mandatory=$false, Position=0)]
        [ValidateRange(0.0,10.0)]
        [PSDefaultValue(Help = 0.2)]
        [Double] $SleepTime = 0.2
    )

    $host_list = @()

    Write-Verbose "Getting domain list"
    $domains = domains.getList.All

    Write-Verbose "$($domains.Count) domains found"

    ForEach($domain in $domains) {
        Start-Sleep -Seconds $sleepTime

        Write-Verbose "Getting host list for $($domain.Name)"
        $hosts = domains.dns.getHosts -DomainName $domain.name

        ForEach($host in $hosts){
            $host_list += $host
        }

    }

    $host_list
}