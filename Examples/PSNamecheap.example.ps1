Import-Module ./PSNamecheap/PSNamecheap.psm1 -Force

<#$hosts = @(
    [ordered]@{HostName = "@"; RecordType = "A"; Address = "192.168.0.1"; TTL = "3600"}
    [ordered]@{HostName = "www"; RecordType = "CNAME"; Address = "brightenfield.com"; TTL = "3600"}
)

$req = domains.dns.setHosts -DomainName "brightenfield.com" -Records $hosts -EmailType "FWD" -Verbose -Debug
$req
$req.ApiResponse
$req.ApiResponse.Errors.Error
#>

$request = api.request @{
    Command = "namecheap.domains.getList"
    ListType = "ALL"
    Page = "1"
    PageSize = "100"
    SortBy = "NAME"
}
$request.DomainGetListResult.Domain | Format-Table -AutoSize

$request = domains.getList
$request.DomainGetListResult.Domain | Format-Table -AutoSize

#$request = api.request @{Command = "namecheap.domains.getList"}

#$request.ApiResponse.CommandResponse.DomainGetListResult.Domain |Format-Table -AutoSize
#$request.ApiResponse
#$request.ApiResponse.CommandResponse.Paging
#(domains.getList -Verbose -Debug).DomainGetListResult.Domain

#$req = domains.getContacts -DomainName brightenfield.com -Verbose -Debug
#$req.DomainContactsResult |Format-Table -AutoSize

#$req = domains.check "brightenfield.co, brightenfield.biz"
#$req | FT -AutoSize

<#
function ExtendObject{
    param(
        [hashtable] $obj1,
        [hashtable] $obj2
    )

    $extend = $obj1.PSObject.Copy()

    foreach($key in $obj2.Keys){
        if($extend.ContainsKey($key)){
            $extend[$key] = $obj2[$key]
        }
        else{
            $extend.Add($key, $obj2[$key])
        }
    }

    return $extend
}

$obj1 = [ordered]@{a = 1; b = 2; c = 3; f = 0;}
$obj2 = [ordered]@{d = 4; e = 4; f = 6;}

$obj1.GetType();
$obj2.GetType();

ExtendObject $obj1 $obj2
#>

<#$turd_req = @{
    fmt = "json"
    type = "search"
    word = "fart"
}

Invoke-WebRequest -Uri "https://brightenfield.org/TurdWords/api" -Method GET -Body $turd_req
#>