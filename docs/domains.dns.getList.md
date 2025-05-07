---
external help file: PSNamecheap-help.xml
Module Name: PSNamecheap
online version: https://www.namecheap.com/support/api/methods/domains-dns/get-list/
schema: 2.0.0
---

# domains.dns.getList

## SYNOPSIS
Gets a list of DNS servers associated with the requested domain.

## SYNTAX

```
domains.dns.getList [-DomainName] <String> [<CommonParameters>]
```

## DESCRIPTION
Gets a list of DNS servers associated with the requested domain.

## EXAMPLES

### EXAMPLE 1
```
domains.dns.getList "example.com"
```

### EXAMPLE 2
```
domains.dns.getList -DomainName "example.com"
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
Can be called by using the DomainName parameter only or the SLD and TLD parameters together. 
However, since multiple parameters across
parameter sets cannot share the same position, you can only omit the parameter name when calling the function with the DomainName parameter set.
If you want to use the SLD.TLD parameter set, you will have to explicitly state the parameter names in the function call.
One could address this by accepting a string argument array as a parameter instead of explicitly specifying each parameter. 
This would allow you
to determine which path to take based on the number of argumnets but it prevent you from writing detailed documentation for Get-Help commands.

## RELATED LINKS

[https://www.namecheap.com/support/api/methods/domains-dns/get-list/](https://www.namecheap.com/support/api/methods/domains-dns/get-list/)

