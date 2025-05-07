---
external help file: PSNamecheap-help.xml
Module Name: PSNamecheap
online version: https://www.namecheap.com/support/api/methods/domains-dns/set-hosts/
schema: 2.0.0
---

# domains.dns.setHosts

## SYNOPSIS
Sets DNS host records settings for the requested domain.

## SYNTAX

```
domains.dns.setHosts [-DomainName] <String> [-Records] <Object[]> [-EmailType] <String> [[-Flag] <Int32>]
 [[-Tag] <String>] [<CommonParameters>]
```

## DESCRIPTION
Sets DNS host records settings for the requested domain.

## EXAMPLES

### EXAMPLE 1
```
$hosts = @(
```

\[ordered\]@{HostName = "@"; RecordType = "A"; Address = "192.168.0.1"; TTL = "3600"}
    \[ordered\]@{HostName = "www"; RecordType = "CNAME"; Address = "example.com"; TTL = "3600"}
)

domains.dns.setHosts -DomainName "example.com" -Records $hosts -EmailType "FWD"

## PARAMETERS

### -DomainName
The domain to setHosts in the format "\<SLD\>.\<TLD\>"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Records
An array of DNS host records (Hashtable or PSCustomObject) to set for the domain.
Each record should contain the following keys/properties:

HostName - Sub-domain/hostname to create the record for
RecordType - Possible values: A, AAAA, ALIAS, CAA, CNAME, MX, MXE, NS, TXT, URL, URL301, FRAME
Address - Possible values are URL or IP address.
The value for this parameter is based on RecordType.
MXPref - MX preference for host.
Applicable for MX records only.
TTL - Time to live for all record types.
Possible values: any value between 60 to 60000.
Default Value: 1800

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EmailType
Possible values are:
MXE - to set up your custom MXE record.
MX - to set up custom MX records of your mail provider.
FWD - to set up MX records for our Free Email Forwarding service.
OX - to set up MX records for our Private Email service.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Flag
Is an unsigned integer between 0 and 255.
The flag value is an 8-bit number, the most significant bit of which indicates the criticality of understanding of a record by a CA.
It's recommended to use '0'

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tag
A non-zero sequence of US-ASCII letters and numbers in lower case.
The tag value can be one of the following values:
issue - specifies the certification authority that is authorized to issue a certificate for the domain name or subdomain record used in the title.
issuewild - specifies the certification authority that is allowed to issue a wildcard certificate for the domain name or subdomain record used in the title.
The certificate applies to the domain name or subdomain directly and to all its subdomains.
iodef - specifies the e-mail address or URL (compliant with RFC 5070) a CA should use to notify a client if any issuance policy violation spotted by this CA.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://www.namecheap.com/support/api/methods/domains-dns/set-hosts/](https://www.namecheap.com/support/api/methods/domains-dns/set-hosts/)

