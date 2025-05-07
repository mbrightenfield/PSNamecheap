---
external help file: PSNamecheap-help.xml
Module Name: PSNamecheap
online version:
schema: 2.0.0
---

# domains.dns.getHosts.All

## SYNOPSIS
Retrieves DNS host record settings for all domains.

## SYNTAX

```
domains.dns.getHosts.All [[-SleepTime] <Double>] [<CommonParameters>]
```

## DESCRIPTION
Calls domains.getList.All to retrieve all domains in the account and then loops through each domain and calls domains.dns.getHosts
and returns the full list.

## EXAMPLES

### EXAMPLE 1
```
$hosts = domains.dns.getHosts.All
```

$hosts | Select-Object Domain, EmailType, IsUsingOurDNS -ExpandProperty Host

## PARAMETERS

### -SleepTime
The time to sleep in seconds between API requests. 
Default: 0.2

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 0.2
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
