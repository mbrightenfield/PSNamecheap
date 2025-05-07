---
external help file: PSNamecheap-help.xml
Module Name: PSNamecheap
online version: https://www.namecheap.com/support/api/methods/domains/check/
schema: 2.0.0
---

# domains.check

## SYNOPSIS
Checks the availability of domains

## SYNTAX

```
domains.check [-DomainList] <String> [<CommonParameters>]
```

## DESCRIPTION
Checks the availability of domains via Namecheap API command namecheap.domains.check

## EXAMPLES

### EXAMPLE 1
```
domains.check -DomainList "example1.com,example2.com,example3.com"
```

## PARAMETERS

### -DomainList
Comma-separated list of domains to check

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

[https://www.namecheap.com/support/api/methods/domains/check/](https://www.namecheap.com/support/api/methods/domains/check/)

