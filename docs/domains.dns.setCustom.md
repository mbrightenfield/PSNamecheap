---
external help file: PSNamecheap-help.xml
Module Name: PSNamecheap
online version: https://www.namecheap.com/support/api/methods/domains-dns/set-custom/
schema: 2.0.0
---

# domains.dns.setCustom

## SYNOPSIS
Sets domain to use custom DNS servers.

## SYNTAX

```
domains.dns.setCustom [-DomainName] <String> [-Nameservers] <String> [<CommonParameters>]
```

## DESCRIPTION
Sets domain to use custom DNS servers via Namecheap API command namecheap.domains.dns.setCustom

## EXAMPLES

### EXAMPLE 1
```
domains.dns.setCustom -DomainName "example.com" -Nameservers "dns1.name-servers.com,dns2.nameservers.com"
```

## PARAMETERS

### -DomainName
The domain name to set custom name servers for

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

### -Nameservers
A comma-separated list of name servers to be associated with this domain

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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

[https://www.namecheap.com/support/api/methods/domains-dns/set-custom/](https://www.namecheap.com/support/api/methods/domains-dns/set-custom/)

