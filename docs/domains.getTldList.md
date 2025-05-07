---
external help file: PSNamecheap-help.xml
Module Name: PSNamecheap
online version: https://www.namecheap.com/support/api/methods/domains/get-tld-list/
schema: 2.0.0
---

# domains.getTldList

## SYNOPSIS
Returns a list of TLDs

## SYNTAX

```
domains.getTldList [<CommonParameters>]
```

## DESCRIPTION
Returns a list of TLDs via Namecheap API command namecheap.domains.getTldList

## EXAMPLES

### EXAMPLE 1
```
$tlds = domains.getTldList
```

$tlds | Format-Table -AutoSize

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
We strongly recommend that you cache this API response to avoid repeated calls.

## RELATED LINKS

[https://www.namecheap.com/support/api/methods/domains/get-tld-list/](https://www.namecheap.com/support/api/methods/domains/get-tld-list/)

