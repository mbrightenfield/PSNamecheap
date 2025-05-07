---
external help file: PSNamecheap-help.xml
Module Name: PSNamecheap
online version: https://www.namecheap.com/support/api/methods/domains/get-list/
schema: 2.0.0
---

# domains.getList.All

## SYNOPSIS
Gets a full list of domains across the Namecheap account

## SYNTAX

```
domains.getList.All [[-PageSize] <Int32>] [[-SleepTime] <Double>] [<CommonParameters>]
```

## DESCRIPTION
Gets a full list of domains across the Namecheap account. 
Since namecheap.domains.getList is a paginated result with a maximum page size of 100
we need to loop through the paginated results to get a full list of domains, if the account has more than 100 domains.

## EXAMPLES

### EXAMPLE 1
```
domains.getList.All | Format-Table -AutoSize
```

## PARAMETERS

### -PageSize
Number of domains to be listed on a page.
Minimum value is 10, and maximum value is 100.
This shouldn't need to be set and will default to 100.
However, it's availalbe if you want to adjust the page size the loop processes.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -SleepTime
The amount of time in seconds to sleep between subsequent API requests per page.
Default: 1.0

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Object[]
## NOTES

## RELATED LINKS

[https://www.namecheap.com/support/api/methods/domains/get-list/](https://www.namecheap.com/support/api/methods/domains/get-list/)

