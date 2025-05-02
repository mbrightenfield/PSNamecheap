<#
.SYNOPSIS
Example for bulk updating DNS records for multiple domains
#>
Import-Module PSNamecheap

# Load the records from CSV export example
$records = Import-Csv "${PSScriptRoot}\PSNamecheap.example.csv.export.csv"

# Since the CSV is flattened and can contain records for multiple domains, let's create 
# a simple hashtable to contain records for each domain we can easily loop through
# and send to domains.dns.setHosts
$domains = @{}

$records | ForEach-Object{
    $domain = $_.Domain
    $emailType = $_.EmailType
    $record = @{
        HostName = $_.HostName
        RecordType = $_.RecordType
        Address = $_.Address
        MXPref = $_.MXPref
        TTL = $_.TTL
    }


    # If domain already exists in hashtable, add DNS record to it
    if($domains.Contains($domain)){
        $domains[$domain].Records += $record
    }
    # Otherwise, create a new domain in the hashtable and add DNS record to it
    else{
        $domains[$domain] = @{
            EmailType = $emailType
            Records = @($record)
        }
    }
}

# Loop through the domain hashtable and set their DNS records via domains.dns.setHosts
$domains.Keys | ForEach-Object {
    $domain = $_
    $emailType = $domains[$_].EmailType
    $records = $domains[$_].Records

    Write-Host "Updating ${domain}"
    Write-Host "Email Type: ${emailType}"
    Write-Host "DNS Records:"
    $records | ForEach-Object {[PSCustomObject] $_} | Format-Table -AutoSize

    # Make Namecheap API call to set DNS records for domain
    $req = domains.dns.setHosts -DomainName $domain -EmailType $emailType -Records $records

    if($req.IsSuccess){
        Write-Host "${domain} Updated Successfully!"
    }
    else{
        Write-Error "${domain} Update Failed!"
    }

    # Sleep to not hammer the API, if there is a very large number of domains
    Start-Sleep -Seconds 1

    Write-Host ("-"*80)
}