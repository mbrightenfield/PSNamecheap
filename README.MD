# PSNamecheap
A Powershell module for interacting with the [Namecheap API](https://www.namecheap.com/support/api/intro/).  Provides the ability to store and load Namecheap API credentials in a config file as well as an `api.request` function that appends the Global Parameters to all API requests.

## Namecheap API
#### Namecheap API Requirements
Your Production or Sandbox Namecheap account must have API Access enabled and an IP address whitelisted. Follow the instructions on the [Namecheap API Intro](https://www.namecheap.com/support/api/intro/) to enable API access.

Your account should meet one of the following requirements:
- have at least 20 domains under your account;
- have at least $50 on your account balance;
- have at least $50 spent within the last 2 years.

#### Namecheap API Limits:
50/min, 700/hour, and 8000/day across the whole key.

**Note**: This module does not do any ratelimiting so if you have a large account that could reach these limits, it's upon you to make sure you do not exceed them.  Some of the [Bulk Functions](#bulk-functions) provide a `SleepTime` parameter 


## Config
There are two functions available for managing the API credeitial configuration.

* `api.config.build` - Prompts user for API credentials and saves them as SecureStrings in a json config file.
* `api.config.load` - Loads default config file.

The default config file is stored at `$PSScriptRoot\PSNamecheap.config.${env:ComputerName}.${env:UserName}.json` and since the Global Parameters are stored as secure strings they can only be decrypted by the user and computer they were generated on.

`api.config.load` is called when the PSNamecheap module is loaded to import the config settings and will throw a warning if there is no default config file found. You will need to call `api.config.build` the first time you load the module to generate a new config file and enter your API credentials.

Example Config
```
{
  "ApiUrl": "https://api.sandbox.namecheap.com/xml.response",
  "Global": {
    "ApiUser": "<Username>",
    "ApiKey": "<API Key>",
    "UserName":"<Username>",
    "ClientIp": "<IPv4 Address>"
  }
}
```

## api.request
`api.request` is the main function for interacting with the Namecheap API and is what is called by all other wrapper functions.  You could interact directly with `api.request` and not use the convenience of the wrapper functions at all. This function takes a `Params` parameter which accepts a `Hashtable` that requires at minimum a `Command` and appends all of the [Global Parameters](https://www.namecheap.com/support/api/global-parameters/) that were defined in the config file except for `Command`.

Under the hood `api.request` makes requests to the API via `Invoke-RestMethod` which takes the Namecheap XML response and converts it to a `[PSCustomObject]` for easy traversal.  `api.request` then traverses the response and returns the `$response.ApiResponse.CommandResponse` portion of the response so you can get to the meat and potatos of the actual response.

Example api.request
```
$request = api.request @{
    Command = "namecheap.domains.getList"
    ListType = "ALL"
    Page = "1"
    PageSize = "100"
    SortBy = "NAME"
}
$request.DomainGetListResult.Domain | Format-Table -AutoSize
```

Result
```
ID      Name        User    Created    Expires    IsExpired IsLocked AutoRenew WhoisGuard IsPremium
--      ----        ----    -------    -------    --------- -------- --------- ---------- ---------
1020463 example.com example 04/22/2025 04/22/2027 false     false    true      ENABLED    false
1020464 example.net example 04/22/2025 04/22/2026 false     false    true      ENABLED    false
1020465 example.org example 04/22/2025 04/22/2026 false     false    true      ENABLED    false
1020466 example.xyz example 04/22/2025 04/22/2026 false     false    true      ENABLED    false
```
## Wrapper Functions
The rest of the functions in this module are wrapper functions that use `api.request` to call the [Namecheap API Methods](https://www.namecheap.com/support/api/methods/) with the `Command` prepopulated and provides some parameter validation and defaults for each method.  They do not follow standard Powershell naming conventions and instead try to mimic the Namecheap API Command names.

All wrapper functions attempt to dig into the response object and return the first child of the `CommandResponse` which is typically named `<Command>Result`.  For example: `domains.getInfo` returns the response's `DomainGetInfoResult`

Example domains.getInfo
```
domains.getInfo "example.com" | Format-Table
```

Result
```
Status ID      DomainName  OwnerName IsOwner IsPremium DomainDetails LockDetails Whoisguard PremiumDnsSubscription
------ --      ----------  --------- ------- --------- ------------- ----------- ---------- ----------------------
Ok     1234567 example.com example   true    false     DomainDetails             Whoisguard PremiumDnsSubscription
```
Example domains.getList
```
$request = domains.getList
$request.DomainGetListResult.Domain | Format-Table -AutoSize
```

`domains.getList` is the only wrapper function that doesn't return the `<Command>Result` from the API response since it is a paginated result and the `Paging` details are at the same level of the command result.

## Bulk Functions
There are a few bulk functions available for getting full lists from across the entire Namecheap account.

* `domains.getList.All` - Loops through the paginated results of `domains.getList` and retuns a list of all domians in the Namecheap account.
* `domains.dns.getHosts.All` - Loops through the results of `domains.getList.All` and calls `domains.dns.getHosts` for each domain to get a full list of DNS records across the entire Namecheap account.

**Note**: If you have a very large account, you'll want to consider adjusting the `SleepTime` parameter for each bulk function to prevent you from exceeding any API limits.