---
external help file: PSNamecheap-help.xml
Module Name: PSNamecheap
online version:
schema: 2.0.0
---

# api.config.build

## SYNOPSIS
Builds config file for Namecheap API credentials and then calls api.config.load.

## SYNTAX

```
api.config.build [[-api] <String>] [[-path] <String>] [-DifferentUserName] [<CommonParameters>]
```

## DESCRIPTION
Builds a JSON config file with ApiURL, ApiUser, UserName, and ApiKey properties.
The users and ApiKey are stored as SecureStrings.
Config filename format: PSNamecheap.config.${env:ComputerName}.${env:UserName}.json

## EXAMPLES

### EXAMPLE 1
```
api.config.build -api "https://api.sandbox.namecheap.com/xml.response" -path "/path/to/config.json"
```

### EXAMPLE 2
```
api.config.build
```

## PARAMETERS

### -api
(Optional) The API URL to use.
Defaults to https://api.sandbox.namecheap.com/xml.response

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: Https://api.sandbox.namecheap.com/xml.response
Accept pipeline input: False
Accept wildcard characters: False
```

### -path
(Optional) The path to the API Credential file to load.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: $default_config_path
Accept pipeline input: False
Accept wildcard characters: False
```

### -DifferentUserName
(Optional) If the ApiUser and UserName Global Parameters are different, set DiffernetUserName to $true.
Default operation is make the UserName value the same as ApiUser.
Default: $false

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
