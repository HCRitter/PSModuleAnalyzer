<#
.SYNOPSIS
Analyzes parameters of functions within a specified module and identifies parameters without descriptions.

.DESCRIPTION
The Invoke-ModuleParameterAnalyzer function imports a specified PowerShell module, retrieves all the functions defined within that module, and analyzes the parameters of each function. It identifies parameters that do not have descriptions and provides a summary of such parameters for each function within the module.

.PARAMETER ModuleName
The name of the module to be analyzed. This parameter is mandatory, and you must specify the name of the module you want to analyze.

.EXAMPLE
Invoke-ModuleParameterAnalyzer -ModuleName 'MyModule'
Analyzes the parameters of functions within the 'MyModule' module and provides a summary of parameters without descriptions.

.NOTES
File Name      : Invoke-ModuleParameterAnalyzer.ps1
Author         : Christian Ritter
Prerequisite   : PowerShell 5.1 or later

#>
function Invoke-ModuleParameterAnalyzer {
    param (
        [Parameter(Mandatory = $true)]
        [string] $ModuleName
    )

    try {
        # Attempt to import the specified module, and if it fails, throw an error message.
        Import-Module -Name $ModuleName -ErrorAction Stop
    } catch {
        throw "No Module:'$ModuleName' was found"
        return  # Exit the function if module import fails.
    }

    # Get the module that was successfully imported.
    $TargetModule = Get-Module -Name $ModuleName

    # Retrieve all the functions defined within the imported module.
    $Functions = Get-Command -Module $TargetModule -CommandType Function

    # Loop through each function in the module.
    foreach($Function in $Functions){
        # Retrieve the parameters of the current function using Get-Help and store them in $Parameter.
        $Parameter = (Get-Help $Function.Name).Parameters.parameter

        # Filter parameters that do not have a description.
        $ParameterWithoutDescription = ($Parameter | Where-Object {[string]::IsNullOrEmpty($_.Description.text)}).Name

        # Create a custom object with function name, parameter count, and parameters without a description.
        [PSCustomObject]@{
            FunctionName = $Function.Name
            ParameterInFunction = $Parameter.Count
            ParameterWithoutDescription = $ParameterWithoutDescription        
        }
    }
}
