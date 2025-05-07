---
external help file: PSNamecheap-help.xml
Module Name: PSNamecheap
online version: https://www.namecheap.com/support/api/methods/domains/get-registrar-lock/
schema: 2.0.0
---

# domains.getRegistrarLock

## SYNOPSIS
Gets the Registrar Lock status for the requested domain

## SYNTAX

```
domains.getRegistrarLock [-DomainName] <String> [<CommonParameters>]
```

## DESCRIPTION
Gets the Registrar Lock status for the requested domain via Namecheap API command namecheap.domains.getRegistrarLock

## EXAMPLES

### EXAMPLE 1
```
domains.getRegistrarLock -DomainName "example.com"
```

### EXAMPLE 2
```
domains.getRegistrarLock example.com
```

## PARAMETERS

### -DomainName
Domain name to get status for

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

[https://www.namecheap.com/support/api/methods/domains/get-registrar-lock/](https://www.namecheap.com/support/api/methods/domains/get-registrar-lock/)

