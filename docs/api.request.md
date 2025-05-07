---
external help file: PSNamecheap-help.xml
Module Name: PSNamecheap
online version:
schema: 2.0.0
---

# api.request

## SYNOPSIS
Makes a request to the Namecheap API

## SYNTAX

```
api.request [[-Params] <Hashtable>] [[-Method] <String>] [-Raw] [<CommonParameters>]
```

## DESCRIPTION
Makes a request to the Namecheap API and appends the Global Parameters defined in the config to the request

## EXAMPLES

### EXAMPLE 1
```
api.request @{Command = "namecheap.domains.getList"}
```

## PARAMETERS

### -Params
A hashtable containing the API parameters to include in the request

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: @{}
Accept pipeline input: False
Accept wildcard characters: False
```

### -Method
The HTTP Method GET or PUT.
Default: GET

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: GET
Accept pipeline input: False
Accept wildcard characters: False
```

### -Raw
Switch to return the raw HTTP request (Invoke-WebRequest) or richly structured data (Invoke-RestMethod).
Default: $false

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
