---
external help file: PSNamecheap-help.xml
Module Name: PSNamecheap
online version: https://www.namecheap.com/support/api/methods/domains-dns/get-hosts/
schema: 2.0.0
---

# domains.dns.getHosts

## SYNOPSIS
Retrieves DNS host record settings for the requested domain.

## SYNTAX

```
domains.dns.getHosts [-DomainName] <String> [<CommonParameters>]
```

## DESCRIPTION
Retrieves DNS host record settings for the requested domain via Namecheap API command namecheap.domains.dns.getHosts

## EXAMPLES

### EXAMPLE 1
```
domains.dns.getHosts "example.com"
```

## PARAMETERS

### -DomainName
The full domain in the format SLD.TLD
Should not be used if specifying SLD and TLD parameters explicitly.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://www.namecheap.com/support/api/methods/domains-dns/get-hosts/](https://www.namecheap.com/support/api/methods/domains-dns/get-hosts/)

