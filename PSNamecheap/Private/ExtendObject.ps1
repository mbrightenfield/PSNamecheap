<#
.SYNOPSIS
Extend the key/value pairs of an object

.DESCRIPTION
Extends/Overwrites the key/value pairs in the first object with the key/value pairs from the second object

.PARAMETER obj1
The primary object to extend

.PARAMETER obj2
The object whose key/value pairs will be added/updated to obj1

.EXAMPLE
ExtendObject @{prop1 = "prop1"; prop2 = "prop2"} @{prop2 = "prop-updated"; prop3 = "prop3"}
#>
function ExtendObject{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [hashtable] $obj1,

        [Parameter(Mandatory=$true, Position=1)]
        [hashtable] $obj2
    )

    Write-Verbose "ExtendObject"
    Write-Debug "obj1: $($obj1 | ConvertTo-Json -Depth 10)"
    Write-Debug "obj2: $($obj2 | ConvertTo-Json -Depth 10)"

    $extend = $obj1.PSObject.Copy()

    foreach($key in $obj2.Keys){
        if($extend.ContainsKey($key)){
            $extend[$key] = $obj2[$key]
        }
        else{
            $extend.Add($key, $obj2[$key])
        }
    }

    return $extend
}