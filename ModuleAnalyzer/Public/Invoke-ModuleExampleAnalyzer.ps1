<#
    .SYNOPSIS
        Analyzes the quality of documentation for functions within a specified PowerShell module.

    .DESCRIPTION
        The Invoke-ModuleExampleAnalyzer function assesses the documentation quality of functions within a given PowerShell module.
        It checks for the presence of aliases, examines associated examples, and identifies any examples that do not match the expected pattern.
        This tool provides insights into the completeness and accuracy of function documentation within the module.

    .PARAMETER ModuleName
        -ModuleName <string>
            Specifies the name of the PowerShell module to be analyzed.

    .EXAMPLE
        Example 1: Analyze Module Documentation

        PS C:\> Invoke-ModuleExampleAnalyzer -ModuleName 'MSGraph'

        This command analyzes the documentation of functions within the 'MSGraph' PowerShell module. It checks for the presence of aliases,
        examines associated examples, and identifies any examples that do not match the expected pattern.

    .AUTHOR
        Christian Ritter

    .VERSION
        1.0

    .NOTES
        Get-Help, Get-Command
#>
function Invoke-ModuleExampleAnalyzer {
    param (
        [Parameter(Mandatory = $true)]
        [string] $ModuleName
    )

    # Check if the module exists

    try{
        Import-Module -Name $ModuleName -ErrorAction Stop
    }catch{
        throw "No Module:'$ModuleName' was found"
        return 
    }

    $TargetModule = Get-Module -Name $ModuleName

    # Collect function names and initialize the hashtable
    $FunctionAliases = @{}
    $Functions = Get-Command -Module $TargetModule -commandtype Function
    foreach($Function in $Functions.Name){
        $FunctionAliases["$($Function)"] = @($Function)
    }

    # Populate the hashtable with aliases
    $Aliases = Get-Command -Module $TargetModule -commandtype Alias
    foreach($alias in $aliases){
        $FunctionAliases["$($alias.ReferencedCommand)"] += $alias.DisplayName
    }

    # Analyze functions and their examples
    foreach($FunctionName in $Functionaliases.Keys){

        $ExamplesList = (Get-Help -Name $FunctionName -Examples).Examples

        # Create a pattern for matching function names or aliases in examples
        $pattern = ($Functionaliases["$($FunctionName)"] | ForEach-Object { [regex]::Escape($_) }) -join '|'
        
        $Index = 1
        # Find and store indices of bad examples that do not match the pattern
        $BadExamples = $ExamplesList.Example.foreach({
            if($PSItem -notmatch $Pattern){
                $Index
            }
            $index++
        })
        [pscustomObject]@{
            FunctionName = $FunctionName
            Examples = $ExamplesList.Example.Count
            BadExamples = $BadExamples
        }
    }
}
