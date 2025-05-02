<#
.SYNOPSIS
Gets a full list of domains across the Namecheap account

.DESCRIPTION
Gets a full list of domains across the Namecheap account.  Since namecheap.domains.getList is a paginated result with a maximum page size of 100
we need to loop through the paginated results to get a full list of domains, if the account has more than 100 domains.

.PARAMETER PageSize
Number of domains to be listed on a page. Minimum value is 10, and maximum value is 100.
This shouldn't need to be set and will default to 100. However, it's availalbe if you want to adjust the page size the loop processes.

.PARAMETER SleepTime
The amount of time in seconds to sleep between subsequent API requests per page. Default: 1.0

.EXAMPLE
domains.getList.All | Format-Table -AutoSize

.LINK
https://www.namecheap.com/support/api/methods/domains/get-list/
#>
function domains.getList.All{
    [CmdletBinding()]
    [OutputType([System.Object[]])]
    param(
        [Parameter(Mandatory=$false, Position=0)]
        [ValidateRange(10,100)]
        [PSDefaultValue(Help = 100)]
        [Int] $PageSize = 100,

        [Parameter(Mandatory=$false, Position=1)]
        [ValidateRange(0.0,10.0)]
        [PSDefaultValue(Help = 1.0)]
        [Double] $SleepTime = 1.0
    )

    Write-Verbose "domains.getList.All: PageSize: ${PageSize}, SleepTime: ${SleepTime}"

    $domain_list = @()

    # Get the first page of results and calculate the number of pages to loop through
    $domains = domains.getList -Page 1 -PageSize $PageSize
    $num_pages = [Math]::Ceiling($domains.Paging.TotalItems/$domains.Paging.PageSize)

    Write-Verbose "domains.getList.All: $($domains.Paging.TotalItems) domains found across ${num_pages} page(s)"

    # Loop through the subsequent pages and add domains to the list.
    for($i = 1; $i -le $num_pages; $i++){

        # We already made the page 1 request so only make additional requests for the pages > 1
        if($i -gt 1){
            if($SleepTime -gt 0.0){
                Start-Sleep -Seconds $SleepTime
            }

            $domains = domains.getList -Page $i -PageSize $PageSize
        }

        # Append domain data to list
        ForEach($domain in $domains.DomainGetListResult.Domain){
            $domain_list += $domain
        }
    }

    return $domain_list
}