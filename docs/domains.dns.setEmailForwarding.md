---
external help file: PSNamecheap-help.xml
Module Name: PSNamecheap
online version: https://www.namecheap.com/support/api/methods/domains-dns/set-email-forwarding/
schema: 2.0.0
---

# domains.dns.setEmailForwarding

## SYNOPSIS
Sets email forwarding for a domain name

## SYNTAX

```
domains.dns.setEmailForwarding [-DomainName] <String> [-Forwards] <Object[]> [<CommonParameters>]
```

## DESCRIPTION
Sets email forwarding for a domain name via Namecheap API command namecheap.domains.dns.setEmailForwarding

## EXAMPLES

### EXAMPLE 1
```
domains.dns.setEmailForwarding -DomaindName "example.com" -Forwards @(@{MailBox="example@example.com"; ForwardTo="example@gmail.com"})
```

## PARAMETERS

### -DomainName
Domain name to set settings

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

### -Forwards
An array of Hashtable or PSCustomObjects containing mailbox forwarding records. 
Each record should contain the following properties:
MailBox - MailBox for which you wish to set email forwarding.
For example: example@namecheap.com
ForwardTo - Email address to forward to.
For example: example@gmail.com

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: True
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

[https://www.namecheap.com/support/api/methods/domains-dns/set-email-forwarding/](https://www.namecheap.com/support/api/methods/domains-dns/set-email-forwarding/)

