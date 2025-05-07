---
external help file: PSNamecheap-help.xml
Module Name: PSNamecheap
online version: https://www.namecheap.com/support/api/methods/domains/set-registrar-lock/
schema: 2.0.0
---

# domains.setRegistrarLock

## SYNOPSIS
Sets the Registrar Lock status for a domain

## SYNTAX

```
domains.setRegistrarLock [-DomainName] <String> [[-LockAction] <String>] [<CommonParameters>]
```

## DESCRIPTION
Sets the Registrar Lock status for a domain

## EXAMPLES

### EXAMPLE 1
```
domains.setRegistrarLock -DomainName "example.com" -LockAction UNLOCK
```

### EXAMPLE 2
```
domains.setRegistrarLock example.com LOCK
```

## PARAMETERS

### -DomainName
Domain name to set status for

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

### -LockAction
Possible values: LOCK, UNLOCK.
Default Value: LOCK.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: LOCK
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://www.namecheap.com/support/api/methods/domains/set-registrar-lock/](https://www.namecheap.com/support/api/methods/domains/set-registrar-lock/)

