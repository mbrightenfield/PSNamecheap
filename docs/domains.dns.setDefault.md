---
external help file: PSNamecheap-help.xml
Module Name: PSNamecheap
online version: https://www.namecheap.com/support/api/methods/domains-dns/set-default/
schema: 2.0.0
---

# domains.dns.setDefault

## SYNOPSIS
Sets domain to use our default DNS servers.

## SYNTAX

```
domains.dns.setDefault [-DomainName] <String> [<CommonParameters>]
```

## DESCRIPTION
Sets domain to use our default DNS servers.
Required for free services like Host record management, URL forwarding, email forwarding, dynamic dns and other value added services.

## EXAMPLES

### EXAMPLE 1
```
domains.dns.setDefault -DomainName "example.com"
```

## PARAMETERS

### -DomainName
Domain to set default DNS server for.

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

[https://www.namecheap.com/support/api/methods/domains-dns/set-default/](https://www.namecheap.com/support/api/methods/domains-dns/set-default/)

