<#
    .SYNOPSIS
    Get the Command and its definition

    .DESCRIPTION
    When you pipe Get-Module with this cmdlet, it return the module name, commands and definitions

    .PARAMETER Module
    Mandatory, Can be piped with Get-Module

    .EXAMPLE
    C:\PS> Get-Module Teamcity | Get-DWCommand

#>
function Get-DWCommand
{
    [CmdletBinding(SupportsShouldProcess)]
    Param
    (
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('Name')]
        [string] $Module,
        
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('ExportedCommands')]
        $Commands
    )

    Process
    {
        $Commands.Keys | % { [pscustomobject]@{ Module=$Module; Command=$_; Definition=(Get-Command $_) | % Definition } }
    }
}
