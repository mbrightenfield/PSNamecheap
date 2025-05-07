---
external help file: PSNamecheap-help.xml
Module Name: PSNamecheap
online version: https://www.namecheap.com/support/api/methods/domains/get-list/
schema: 2.0.0
---

# domains.getList

## SYNOPSIS
Returns a list of domains for the particular user

## SYNTAX

```
domains.getList [[-ListType] <String>] [[-SearchTerm] <String>] [[-Page] <Int32>] [[-PageSize] <Int32>]
 [[-SortBy] <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns a list of domains for the particular user via Namecheap API command namecheap.domains.getList

## EXAMPLES

### EXAMPLE 1
```
$domains = domains.getList
```

$domains.Paging | Format-Table -AutoSize
$domains.DomainGetListResult.Domain | Format-Table -AutoSize

### EXAMPLE 2
```
domains.getList -ListType "Expiring" -SearchTerm ".com"
```

## PARAMETERS

### -ListType
Possible values are ALL, EXPIRING, or EXPIRED.
Default Value: ALL

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: ALL
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchTerm
Keyword to look for in the domain list

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

### -Page
Page to return.
Default Value: 1

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -PageSize
Number of domains to be listed on a page.
Minimum value is 10, and maximum value is 100.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -SortBy
Possible values are NAME, NAME_DESC, EXPIREDATE, EXPIREDATE_DESC, CREATEDATE, CREATEDATE_DESC

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: NAME
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://www.namecheap.com/support/api/methods/domains/get-list/](https://www.namecheap.com/support/api/methods/domains/get-list/)

