---
external help file: PSNamecheap-help.xml
Module Name: PSNamecheap
online version: https://www.namecheap.com/support/api/methods/domains/get-info/
schema: 2.0.0
---

# domains.getInfo

## SYNOPSIS
Returns information about the requested domain

## SYNTAX

```
domains.getInfo [-DomainName] <String> [[-HostName] <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns information about the requested domain

## EXAMPLES

### EXAMPLE 1
```
domains.getInfo -DomainName "example.com"
```

## PARAMETERS

### -DomainName
Domain name for which domain information needs to be requested

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

### -HostName
Hosted domain name for which domain information needs to be requested

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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

[https://www.namecheap.com/support/api/methods/domains/get-info/](https://www.namecheap.com/support/api/methods/domains/get-info/)

