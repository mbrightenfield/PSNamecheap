---
external help file: PSNamecheap-help.xml
Module Name: PSNamecheap
online version: https://www.namecheap.com/support/api/methods/domains/reactivate/
schema: 2.0.0
---

# domains.reactivate

## SYNOPSIS
Reactivates an expired domain

## SYNTAX

```
domains.reactivate [-DomainName] <String> [[-PromotionCode] <String>] [[-YearsToAdd] <Int32>]
 [[-IsPremiumDomain] <Boolean>] [[-PremiumPrice] <Double>] [<CommonParameters>]
```

## DESCRIPTION
Reactivates an expired domain via Namecheap API command namecheap.domains.reactivate

## EXAMPLES

### EXAMPLE 1
```
domains.reactivate -DomainName "example.com" -YearstoAdd 1
```

## PARAMETERS

### -DomainName
Domain name to reactivate

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

### -PromotionCode
Promotional (coupon) code for reactivating the domain

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

### -YearsToAdd
Number of years after expiry

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsPremiumDomain
Indication if the domain name is premium

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PremiumPrice
Reactivation price for the premium domain

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://www.namecheap.com/support/api/methods/domains/reactivate/](https://www.namecheap.com/support/api/methods/domains/reactivate/)

