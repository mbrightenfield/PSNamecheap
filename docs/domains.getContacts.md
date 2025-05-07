---
external help file: PSNamecheap-help.xml
Module Name: PSNamecheap
online version: https://www.namecheap.com/support/api/methods/domains/get-contacts/
schema: 2.0.0
---

# domains.getContacts

## SYNOPSIS
Gets contact information for the requested domain

## SYNTAX

```
domains.getContacts [-DomainName] <String> [<CommonParameters>]
```

## DESCRIPTION
namecheap.domains.getContacts - Gets contact information for the requested domain

## EXAMPLES

### EXAMPLE 1
```
domains.getContacts -DomainName "example.com"
```

### EXAMPLE 2
```
domains.getContacts "example.com"
```

## PARAMETERS

### -DomainName
Domain to get contacts for

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

[https://www.namecheap.com/support/api/methods/domains/get-contacts/](https://www.namecheap.com/support/api/methods/domains/get-contacts/)

