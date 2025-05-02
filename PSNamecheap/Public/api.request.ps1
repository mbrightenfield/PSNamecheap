<#
.SYNOPSIS
Makes a request to the Namecheap API

.DESCRIPTION
Makes a request to the Namecheap API and appends the Global Parameters defined in the config to the request

.PARAMETER Params
A hashtable containing the API parameters to include in the request

.PARAMETER Method
The HTTP Method GET or PUT. Default: GET

.PARAMETER Raw
Switch to return the raw HTTP request (Invoke-WebRequest) or richly structured data (Invoke-RestMethod). Default: $false

.EXAMPLE
api.request @{Command = "namecheap.domains.getList"}
#>
function api.request {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false, Position=0)]
        [hashtable] $Params = @{},

        [Parameter(Mandatory=$false, Position=1)]
        [ValidateSet("GET", "POST")]
        [PSDefaultValue(Help = "GET")]
        [string] $Method = "GET",

        [Parameter(Mandatory=$false, Position=2)]
        [PSDefaultValue(Help = $false)]
        [switch] $Raw = $false
    )

    Write-Verbose "Namecheap API Request: $($Params.Command) ${Method}"

    if($null -eq $config.Global){
        throw "API Config not loaded."
    }

    # Merge Global Parameters
    $request_params = ExtendObject $config.Global $Params

    Write-Debug "Namecheap API URL: $($config.ApiUrl)"
    Write-Debug ($request_params | ConvertTo-Json)

    # Make Request
    try{
        $user_agent = "$($MyInvocation.MyCommand.ModuleName)-$($MyInvocation.MyCommand.Module.Version)"

        if($Raw){
            Invoke-WebRequest -Uri $config.ApiUrl -Method $Method -Body $request_params -UserAgent $user_agent
        }
        else{
            $request = Invoke-RestMethod -Uri $config.ApiUrl -Method $Method -Body $request_params -UserAgent $user_agent

            if($request.ApiResponse.Status -eq "OK"){
                return $request.ApiResponse.CommandResponse
            }
            else{
                #Write-Error "Request Failed!"
                ForEach($err in $request.ApiResponse.Errors.Error){
                    Write-Error "Error ($($err.Number)) $($err."#text")"
                }
            }
        }
    }
    catch{
        Write-Error "Error making API Request."
        Write-Error $_
    }
}