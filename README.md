# ModuleAnalyzer

ModuleAnalyzer is a PowerShell module designed to enhance the documentation quality assessment of PowerShell modules. It provides two essential functions: `Invoke-ModuleParameterAnalyzer` and `Invoke-ModuleExampleAnalyzer`. These functions allow you to analyze and improve the documentation of functions within a specified module.

## Invoke-ModuleParameterAnalyzer

### SYNOPSIS

Analyzes parameters of functions within a specified module and identifies parameters without descriptions.

### DESCRIPTION

The `Invoke-ModuleParameterAnalyzer` function imports a specified PowerShell module, retrieves all the functions defined within that module, and analyzes the parameters of each function. It identifies parameters that do not have descriptions and provides a summary of such parameters for each function within the module.

### PARAMETERS

- **ModuleName** (Mandatory)
  - The name of the module to be analyzed. You must specify the name of the module you want to analyze.

### EXAMPLE

```powershell
Invoke-ModuleParameterAnalyzer -ModuleName 'MyModule'
```

This command analyzes the parameters of functions within the 'MyModule' module and provides a summary of parameters without descriptions.

### AUTHOR

Christian Ritter

### PREREQUISITES

PowerShell 5.1 or later

## Invoke-ModuleExampleAnalyzer

### SYNOPSIS

Analyzes the quality of documentation for functions within a specified PowerShell module.

### DESCRIPTION

The `Invoke-ModuleExampleAnalyzer` function assesses the documentation quality of functions within a given PowerShell module. It checks for the presence of aliases, examines associated examples, and identifies any examples that do not match the expected pattern. This tool provides insights into the completeness and accuracy of function documentation within the module.

### PARAMETERS

- **ModuleName** (Mandatory)
  - Specifies the name of the PowerShell module to be analyzed.

### EXAMPLE

```powershell
Invoke-ModuleExampleAnalyzer -ModuleName 'MSGraph'
```

This command analyzes the documentation of functions within the 'MSGraph' PowerShell module. It checks for the presence of aliases, examines associated examples, and identifies any examples that do not match the expected pattern.

### AUTHOR

Christian Ritter

### VERSION

0.1.0

### PREREQUISITES

- PowerShell 5.1 or later

## Installation

To use ModuleAnalyzer, you can download the module from the [GitHub repository](https://github.com/HCRitter/PSModuleAnalyzer).

## Usage

1. Import the module using `Import-Module -Name ModuleAnalyzer`.

2. Use the `Invoke-ModuleParameterAnalyzer` and `Invoke-ModuleExampleAnalyzer` functions to analyze the documentation quality of your PowerShell modules.

## Feedback and Contributions

We welcome your feedback and contributions to improve ModuleAnalyzer. Feel free to submit issues, suggestions, or pull requests on our [GitHub repository](https://github.com/HCRitter/PSModuleAnalyzer).

## License

This project is licensed under the [MIT License](LICENSE)
