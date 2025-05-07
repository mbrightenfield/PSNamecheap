---
external help file: PSNamecheap-help.xml
Module Name: PSNamecheap
online version:
schema: 2.0.0
---

# api.config.load

## SYNOPSIS
Load Namecheap API Credentials from Config File

## SYNTAX

```
api.config.load [[-path] <String>] [<CommonParameters>]
```

## DESCRIPTION
Load Namecheap API Credentials from Config File. 
The default config file is located at $PSScriptRoot\PSNamecheap.config.${env:ComputerName}.${env:UserName}.json

## EXAMPLES

### EXAMPLE 1
```
# Load modules default config (gets called when module is loaded)
```

api.config.load

### EXAMPLE 2
```
api.config.load -path "/path/to/config.json"
```

## PARAMETERS

### -path
(Optional) The path to load the config file from, if the default locaiton is undesired.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $default_config_path
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
