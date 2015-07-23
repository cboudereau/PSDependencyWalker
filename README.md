# PSDependencyWalker

## Get-DWCommand
Get the Command and its definition
When you pipe Get-Module with this cmdlet, it return the module name, commands and definitions
```powershell
C:\PS> Get-Module Get-TCBuildType | Get-DWCommand
```

## Get-DWDependencies
Get the dependencies for a given DWCommand
It is hard to get cmdlet dependencies in order to refactor powershell cmdlet. With this you can analyse impact
this cmdlet return the module name, command name and dependencies
  
```powershell
Get-module teamcity | Get-DWCommand | Get-DWDependencies
```

## How to Analyse Dependencies
1. Get the command of the module to refactor for example Teamcity Module
```powershell
$teamcity = Get-module teamcity | Get-DWCommand | % Command
```
2. Get the dependencies for all installed modules
```powershell
Get-module | Get-DWCommand | Get-DWDependencies | ? { $teamcity -contains $_.Dependency }
```
