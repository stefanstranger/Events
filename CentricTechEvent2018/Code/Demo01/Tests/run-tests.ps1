param (
    [string]
    $testScript
)
# This script executes verification tests against the ARM template.

# region Install Pester
Write-Host "Installing Pester..."
Install-PackageProvider -Name NuGet -Force -Scope CurrentUser
Install-Module -Name Pester -Force -Scope CurrentUser -SkipPublisherCheck
#endregion

#region call Pester script
Write-Host "Execute Pester tests..."

$result = Invoke-Pester -Script $(Join-Path $PSScriptRoot $testScript) -PassThru -Verbose -Debug -EnableExit -OutputFile $(Join-Path "$env:SYSTEM_DEFAULTWORKINGDIRECTORY" "TestResults.xml") -OutputFormat NUnitXml
if ($result.failedCount -ne 0) { 
    Write-Error "Pester returned errors"
}
#endregion

<#
 Run from Demo01 folder
 invoke-pester -Script @{'Path' = './Tests/arm.tests.ps1'; 'Parameters' = @{'Location'='WestEurope';'ResourceGroupName'='centric-rg';'ARMTemplateName'='WebAppContainer.json'}}
#>