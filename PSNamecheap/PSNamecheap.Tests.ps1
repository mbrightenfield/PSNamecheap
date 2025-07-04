<#
.SYNOPSIS
Pester tests for module and functions

.DESCRIPTION
Sets up basic standard tests for module/functions as well as loads any separate tests for individual functions

.LINK
https://github.com/andrewmatveychuk/powershell.sample-module
#>

BeforeAll {
    # For use within the tests, during the Run phase
    $here = Split-Path -Parent $PSCommandPath
  
    #region Reloading SUT
    # Ensuring that we are testing this version of module and not any other version that could be in memory
    $modulePath = "$($PSCommandPath -replace '.Tests.ps1$', '').psm1"
    $moduleName = (($modulePath | Split-Path -Leaf) -replace '.psm1')
    @(Get-Module -Name $moduleName).where({ $_.version -ne '0.0' }) | Remove-Module # Removing all module versions from the current context if there are any
    Import-Module -Name $modulePath -Force -ErrorAction Stop # Loading module explicitly by path and not via the manifest
    #endregion
  }
  
  Describe "'$moduleName' Module Tests" {
  
    Context 'Module Setup' {
      It "should have a root module" {
        Test-Path $modulePath | Should -Be $true
      }
  
      It "should have an associated manifest" {
        Test-Path "$here\$moduleName.psd1" | Should -Be $true
      }
  
      It "should have public functions" {
        Test-Path "$here\public\*.ps1" | Should -Be $true
      }
  
      It "should be a valid PowerShell code" {
        $psFile = Get-Content -Path $modulePath -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
        $errors.Count | Should -Be 0
      }
    }
  
    Context "Module Control" {
      It "should import without errors" {
        { Import-Module -Name $modulePath -Force -ErrorAction Stop } | Should -Not -Throw
        Get-Module -Name $moduleName | Should -Not -BeNullOrEmpty
      }
  
      It 'should remove without errors' {
        { Remove-Module -Name $moduleName -ErrorAction Stop } | Should -Not -Throw
        Get-Module -Name $moduleName | Should -BeNullOrEmpty
      }
    }
  }
  
  # Duplicated from the BeforeAll above.
  # Implicitly runs during Discovery, required to populate
  # $functionPaths for Pester to properly generate the tests
  $here = Split-Path -Parent $PSCommandPath
  
  # Dynamically defining the functions to test
  $functionPaths = @()
  if (Test-Path -Path "$here\Private\*.ps1") {
    $functionPaths += Get-ChildItem -Path "$here\Private\*.ps1" -Exclude "*.Tests.*"
  }
  if (Test-Path -Path "$here\Public\*.ps1") {
    $functionPaths += Get-ChildItem -Path "$here\Public\*.ps1" -Exclude "*.Tests.*"
  }
  
  Describe "'<_>' Function Tests" -ForEach $functionPaths {
    BeforeDiscovery {
        # Required in order to populate $parameters during discovery to find all parameters
        # Getting function
        $AbstractSyntaxTree = [System.Management.Automation.Language.Parser]::ParseInput((Get-Content -raw $_), [ref]$null, [ref]$null)
        $AstSearchDelegate = { $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }
        $ParsedFunction = $AbstractSyntaxTree.FindAll( $AstSearchDelegate, $true ) | Where-Object Name -eq $_.BaseName
  
        # Getting the list of function parameters
        $parameters = @($ParsedFunction.Body.ParamBlock.Parameters.name.VariablePath.Foreach{ $_.ToString() })
    }
  
    BeforeAll {
      $functionName = $_.BaseName
      $functionPath = $_
    }
  
    Context "Function Code Style Tests" {
      It "should be an advanced function" {
        $functionPath | Should -FileContentMatch 'Function'
        $functionPath | Should -FileContentMatch 'CmdletBinding'
        $functionPath | Should -FileContentMatch 'Param'
      }
  
      It "should contain Write-Verbose blocks" {
        $functionPath | Should -FileContentMatch 'Write-Verbose'
      }
  
      It "should be a valid PowerShell code" {
        $psFile = Get-Content -Path $functionPath -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
        $errors.Count | Should -Be 0
      }
  
      It "should have tests" -Skip {
        Test-Path ($functionPath -replace ".ps1", ".Tests.ps1") | Should -Be $true
        ($functionPath -replace ".ps1", ".Tests.ps1") | Should -FileContentMatch "Describe `"'$functionName'"
      }
    }
  
    Context "Function Help Quality Tests" {
      BeforeAll {
        # Getting function help
        $AbstractSyntaxTree = [System.Management.Automation.Language.Parser]::ParseInput((Get-Content -raw $functionPath), [ref]$null, [ref]$null)
        $AstSearchDelegate = { $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }
        $ParsedFunction = $AbstractSyntaxTree.FindAll( $AstSearchDelegate, $true ) | Where-Object Name -eq $functionName
        $functionHelp = $ParsedFunction.GetHelpContent()
      }
  
      It "should have a SYNOPSIS" {
        $functionHelp.Synopsis | Should -Not -BeNullOrEmpty
      }
  
      It "should have a DESCRIPTION with length > 40 symbols" {
        $functionHelp.Description.Length | Should -BeGreaterThan 40
      }
  
      It "should have at least one EXAMPLE" {
        $functionHelp.Examples.Count | Should -BeGreaterThan 0
        $functionHelp.Examples[0] | Should -Match ([regex]::Escape($functionName))
        $functionHelp.Examples[0].Length | Should -BeGreaterThan ($functionName.Length + 10)
      }
  
      $parameters | ForEach-Object {
        It "should have descriptive help for '<parameter>' parameter" -TestCases @{parameter = $_} {
          $functionHelp.Parameters.($parameter.ToUpper()) | Should -Not -BeNullOrEmpty
          $functionHelp.Parameters.($parameter.ToUpper()).Length | Should -BeGreaterThan 25
        }
      }
    }
  }