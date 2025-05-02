<#
.SYNOPSIS
    Build script

.DESCRIPTION
    This script contains the tasks for building the 'PSNamecheap' PowerShell module

.EXAMPLE
    Invoke-Build -Task Build

.LINK
https://github.com/nightroman/Invoke-Build
https://github.com/andrewmatveychuk/powershell.sample-module
#>

param(
    [ValidateSet("Debug", "Release")]
    [string] $Configuration = "Debug"
)

if($MyInvocation.ScriptName -notlike "*Invoke-Build.ps1"){
    if(!(Get-Command Invoke-Build -ErrorAction SilentlyContinue)){
        Install-Module InvokeBuild -Scope CurrentUser -Force
        Import-Module InvokeBuild
    }

    Invoke-Build @PSBoundParameters -File $MyInvocation.MyCommand.Path
    return
}

# Default Task
task . clean, build

# Install build dependencies
Enter-Build {

    # Installing PSDepend for dependency management
    if (-not (Get-Module -Name PSDepend -ListAvailable)) {
        Install-Module PSDepend -Scope CurrentUser -Force
    }
    Import-Module PSDepend

    # Installing dependencies
    Invoke-PSDepend -Force

    # Setting build script variables
    $script:moduleName = 'PSNamecheap'
    $script:moduleSourcePath = Join-Path -Path $BuildRoot -ChildPath $moduleName
    $script:moduleManifestPath = Join-Path -Path $moduleSourcePath -ChildPath "$moduleName.psd1"
    $script:nuspecPath = Join-Path -Path $moduleSourcePath -ChildPath "$moduleName.nuspec"
    $script:buildOutputPath = Join-Path -Path $BuildRoot -ChildPath 'build'

    # Setting base module version and using it if building locally
    $script:newModuleVersion = New-Object -TypeName 'System.Version' -ArgumentList (0, 0, 1)

    # Setting the list of functions to be exported by module
    $script:functionsToExport = (Test-ModuleManifest $moduleManifestPath).ExportedFunctions
}

# Synopsis: Analyze the project with PSScriptAnalyzer
task Analyze {
    # Get-ChildItem parameters
    $TestFiles = Get-ChildItem -Path $moduleSourcePath -Recurse -Include "*.PSSATests.*"
    
    $Config = New-PesterConfiguration @{
        Run = @{
            Path = $TestFiles
            Exit = $true
        }
        TestResult = @{
            Enabled = $true
        }
    }

    # Additional parameters on Azure Pipelines agents to generate test results
    if ($env:TF_BUILD) {
        if (-not (Test-Path -Path $buildOutputPath -ErrorAction SilentlyContinue)) {
            New-Item -Path $buildOutputPath -ItemType Directory
        }
        $Timestamp = Get-date -UFormat "%Y%m%d-%H%M%S"
        $PSVersion = $PSVersionTable.PSVersion.Major
        $TestResultFile = "AnalysisResults_PS$PSVersion`_$TimeStamp.xml"
        $Config.TestResult.OutputPath = "$buildOutputPath\$TestResultFile"
    }

    # Invoke all tests
    Invoke-Pester -Configuration $Config
}

# Synopsis: Test the project with Pester tests
task Test {
    $TestFiles = Get-ChildItem -Path $moduleSourcePath -Recurse -Include "*.Tests.*"

    Write-Host $moduleSourcePath
    
    $Config = New-PesterConfiguration @{
        Run = @{
            Path = $TestFiles
            Exit = $true
        }
        TestResult = @{
            Enabled = $true
        }
    }

    # Additional parameters on Azure Pipelines agents to generate test results
    if ($env:TF_BUILD) {
        if (-not (Test-Path -Path $buildOutputPath -ErrorAction SilentlyContinue)) {
            New-Item -Path $buildOutputPath -ItemType Directory
        }

        $Timestamp = Get-date -UFormat "%Y%m%d-%H%M%S"
        $PSVersion = $PSVersionTable.PSVersion.Major
        $TestResultFile = "TestResults_PS$PSVersion`_$TimeStamp.xml"
        $Config.TestResult.OutputPath = "$buildOutputPath\$TestResultFile"
    }

    # Invoke all tests
    Invoke-Pester -Configuration $Config
}

# Synopsis: Generate a new module version if creating a release build
task GenerateNewModuleVersion -If ($Configuration -eq 'Release') {
    # Using the current NuGet package version from the feed as a version base when building via Azure DevOps pipeline

    # Define package repository name
    $repositoryName = "Local-PSRepo"
    $SourceLocation = "F:\scripts\PowerShell\_REPO"

    # Register a target PSRepository
    try {
        Register-PSRepository -Name $repositoryName -SourceLocation $SourceLocation -InstallationPolicy Trusted
    }
    catch {
        throw "Cannot register '$repositoryName' repository with source location '$SourceLocation'!"
    }

    # Define variable for existing package
    $existingPackage = $null

    try {
        # Look for the module package in the repository
        $existingPackage = Find-Module -Name $moduleName -Repository $repositoryName
    }
    # In no existing module package was found, the base module version defined in the script will be used
    catch {
        Write-Warning "No existing package for '$moduleName' module was found in '$repositoryName' repository!"
    }

    # If existing module package was found, try to install the module
    if ($existingPackage) {
        # Get the largest module version
        # $currentModuleVersion = (Get-Module -Name $moduleName -ListAvailable | Measure-Object -Property 'Version' -Maximum).Maximum
        $currentModuleVersion = New-Object -TypeName 'System.Version' -ArgumentList ($existingPackage.Version)

        # Set module version base numbers
        [int]$Major = $currentModuleVersion.Major
        [int]$Minor = $currentModuleVersion.Minor
        [int]$Build = $currentModuleVersion.Build

        try {
            # Install the existing module from the repository
            Install-Module -Name $moduleName -Repository $repositoryName -RequiredVersion $existingPackage.Version -Force -Scope CurrentUser
        }
        catch {
            throw "Cannot import module '$moduleName'!"
        }

        # Get the count of exported module functions
        $existingFunctionsCount = (Get-Command -Module $moduleName | Where-Object -Property Version -EQ $existingPackage.Version | Measure-Object).Count
        # Check if new public functions were added in the current build
        [int]$sourceFunctionsCount = (Get-ChildItem -Path "$moduleSourcePath\Public\*.ps1" -Exclude "*.Tests.*" | Measure-Object).Count
        [int]$newFunctionsCount = [System.Math]::Abs($sourceFunctionsCount - $existingFunctionsCount)

        Write-Host "Existing Functions: ${existingFunctionsCount}"
        Write-Host "Source Functions Count: ${sourceFunctionsCount}"

        # Increase the minor number if any new public functions have been added
        if ($newFunctionsCount -gt 0) {
            [int]$Minor = $Minor + 1
            [int]$Build = 0
        }
        # If not, just increase the build number
        else {
            [int]$Build = $Build + 1
        }

        # Update the module version object
        $Script:newModuleVersion = New-Object -TypeName 'System.Version' -ArgumentList ($Major, $Minor, $Build)
    }
}

# Synopsis: Generate list of functions to be exported by module
task GenerateListOfFunctionsToExport {
    # Set exported functions by finding functions exported by *.psm1 file via Export-ModuleMember
    $params = @{
        Force    = $true
        Passthru = $true
        Name     = (Resolve-Path (Get-ChildItem -Path $moduleSourcePath -Filter '*.psm1')).Path
    }
    $PowerShell = [Powershell]::Create()
    [void]$PowerShell.AddScript(
        {
            Param ($Force, $Passthru, $Name)
            $module = Import-Module -Name $Name -PassThru:$Passthru -Force:$Force
            $module | Where-Object { $_.Path -notin $module.Scripts }
        }
    ).AddParameters($Params)
    $module = $PowerShell.Invoke()
    $Script:functionsToExport = $module.ExportedFunctions.Keys
}

# Synopsis: Update the module manifest with module version and functions to export
task UpdateModuleManifest GenerateListOfFunctionsToExport, GenerateNewModuleVersion, {
    # Update-ModuleManifest parameters
    $Params = @{
        Path              = $moduleManifestPath
        ModuleVersion     = $newModuleVersion
        FunctionsToExport = $functionsToExport
    }

    # Update the manifest file
    Update-ModuleManifest @Params
}

# Synopsis: Update the NuGet package specification with module version
task UpdatePackageSpecification GenerateNewModuleVersion, {
    # Load the specification into XML object
    $xml = New-Object -TypeName 'XML'
    $xml.Load($nuspecPath)

    # Update package version
    $metadata = Select-XML -Xml $xml -XPath '//package/metadata'
    $metadata.Node.Version = $newModuleVersion

    # Save XML object back to the specification file
    $xml.Save($nuspecPath)
}

# Build
task build UpdateModuleManifest, UpdatePackageSpecification, {
    # Warning on local builds
    if ($Configuration -eq 'Debug') {
        Write-Warning "Creating a debug build. Use it for test purpose only!"
    }

    # Create versioned output folder
    $Script:moduleOutputPath = Join-Path -Path $buildOutputPath -ChildPath $moduleName -AdditionalChildPath $newModuleVersion
    if (-not (Test-Path $Script:moduleOutputPath)) {
        New-Item -Path $Script:moduleOutputPath -ItemType Directory
    }

    # Copy-Item parameters
    $Params = @{
        Path        = "$moduleSourcePath\*"
        Destination = $moduleOutputPath
        Exclude     = "Tests", "*.Tests.*", "*.PSSATests.*", "*.config.*.json", "*.csv"
        Recurse     = $true
        Force       = $true
    }

    # Copy module files to the target build folder
    Copy-Item @Params
}

# Deploy
task publish clean, build, {
    if ($Configuration -eq 'Release') {
        $config = @{
            Path = $Script:moduleOutputPath
            Repository = "Local-PSRepo"
            NuGetAPIKey = "N/A"
        }
        
        Publish-Module @config
    }
    else{
        Write-Warning "Can only deploy Release builds."
    }
}

# Clean up the target build directory
task clean {
    if (Test-Path $buildOutputPath) {
        Remove-Item -Path $buildOutputPath -Recurse
    }
}