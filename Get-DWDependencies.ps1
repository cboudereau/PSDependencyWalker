<#
    .SYNOPSIS
    Get the dependencies for a given DWCommand

    .DESCRIPTION
    It is hard to get cmdlet dependencies in order to refactor powershell cmdlet. With this you can analyse impact
    this cmdlet return the module name, command name and dependencies

    .PARAMETER Module
    Mandatory, Can be piped with Get-DWCommand

    .PARAMETER Command
    Mandatory, Can be piped with Get-DWCommand

    .PARAMETER Definition
    Mandatory, Can be piped with Get-DWCommand

    .EXAMPLE
    C:\PS> Get-module teamcity | Get-DWCommand | Get-DWDependencies

#>
function Get-DWDependencies
{
    [CmdletBinding(SupportsShouldProcess)]
    Param
    (
        [Parameter(ValueFromPipelineByPropertyName)]
        [string] $Module,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string] $Command,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string] $Definition
    )

    Process
    {
        $errors = $null
        $parser = [System.Management.Automation.PSParser]::Tokenize($Definition, [ref]$errors)
        $dependencies = $parser | ? {$_.Type -eq "Command"} | % Content | Select-Object -Unique
        
        $dependencies | % { [pscustomobject]@{ Module=$Module; Command=$Command; Dependency = $_ } }
    }
}