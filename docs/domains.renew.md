---
external help file: PSNamecheap-help.xml
Module Name: PSNamecheap
online version: https://www.namecheap.com/support/api/methods/domains/renew/
schema: 2.0.0
---

# domains.renew

## SYNOPSIS
Renews an expiring domain

## SYNTAX

```
domains.renew [-DomainName] <String> [-Years] <Int32> [[-PromotionCode] <String>]
 [[-IsPremiumDomain] <Boolean>] [[-PremiumPrice] <Double>] [<CommonParameters>]
```

## DESCRIPTION
Renews an expiring domain via Namecheaps API command namecheap.domains.renew

## EXAMPLES

### EXAMPLE 1
```
domains.renew -DomainName "example.com" -Years 1
```

## PARAMETERS

### -DomainName
The Domain Name to renew

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

### -Years
Number of years to renew

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -PromotionCode
Promotional (coupon) code for renewing the domain

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
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
Renewal price for the premium domain

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

[https://www.namecheap.com/support/api/methods/domains/renew/](https://www.namecheap.com/support/api/methods/domains/renew/)

