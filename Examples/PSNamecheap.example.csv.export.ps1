<#
.SYNOPSIS
Example script for exporting all DNS records from Namecheap and writing to CSV
#>
Import-Module PSNamecheap

$out_file = "${PSScriptRoot}\PSNamecheap.example.csv.export.csv"

# Make bulk API request
$domains = domains.dns.getHosts.All

# Flatted the results to create a row for each host record
$host_list = $domains | Select-Object Domain, EmailType, IsUsingOurDNS -ExpandProperty Host

# Output results to CSV and rename a couple properties so the CSV can be fed back in to a bulk setHosts example later
# (Host "Name" and "Type" properties are "HostName" and "RecordType" for Namecheap's setHosts command)
$host_list | Select-Object Domain,
    EmailType,
    IsUsingOurDNS,
    HostId,
    @{Name = "HostName"; Expression = "Name"},
    @{Name = "RecordType"; Expression = "Type"},
    Address,
    MXPref,
    TTL,
    AssociatedAppTitle,
    FriendlyName,
    IsActive,
    IsDDNSEnabled
    | ConvertTo-Csv -NoTypeInformation
    | Out-File $out_file

Write-Host "$($host_list.Count) total host records across $($domains.Count) domains written to ${out_file}"