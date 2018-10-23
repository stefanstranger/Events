#Requires -Modules Pester
<#
.SYNOPSIS
    Tests a specific ARM template
.EXAMPLE
    Invoke-Pester
.NOTES
    This file has been created as an example of using Pester to evaluate ARM templates
#>

param (
    [string]$Location,
    [string]$ResourceGroupName,
    [string]$ARMTemplateName
        
)

$root = $(Split-Path $PSScriptRoot -Parent)
#$template = (join-path $(Join-Path $root 'Templates') $ARMTemplateName)
$template = 'C:\Users\stefstr\Documents\GitHub\Events\CentricTechEvent2018\Code\Demo01\Templates\WebAppContainer.json'

Describe "Template: $template" {

    Context "Template Syntax" {
        It "Has a JSON template" {
            $template | Should Exist
        }

        It "Converts from JSON and has the expected properties" {
            $expectedProperties = '$schema',
            'contentVersion',
            'parameters',
            'variables',
            'resources',
            'outputs' | Sort-Object -Descending
            $templateProperties = (get-content $template | ConvertFrom-Json -ErrorAction SilentlyContinue) | Get-Member -MemberType NoteProperty | Sort-Object -Property NoteProperty | % Name | Sort-Object -Descending 
            $templateProperties | Should Be $expectedProperties
        }

        It "Creates the expected Azure resources" {
            $expectedResources = 'Microsoft.Resources/resourceGroups',
            'Microsoft.Resources/deployments' | Sort-Object -Descending
            $templateResources = (get-content $template | ConvertFrom-Json -ErrorAction SilentlyContinue).Resources.type | Sort-Object -Property NoteProperty | Sort-Object -Descending
            $templateResources | Should Be $expectedResources
            $expecteddeploymentResources = 'Microsoft.Web/sites',
            'Microsoft.Web/sites/hostNameBindings' | Sort-Object -Descending
            $deploymentResources = (get-content $template | ConvertFrom-Json -ErrorAction SilentlyContinue).Resources.properties.template.resources.type | Sort-Object -Property NoteProperty | Sort-Object -Descending
            $deploymentResources | Should Be $expecteddeploymentResources
        }
    }

    <#
    Context "Template Validation" {

        BeforeAll {
            $shortGUID = ([system.guid]::newguid().guid).Substring(0, 3)
            $tempRg = "$shortGUID-Pester-RG"
            New-AzureRmResourceGroup -Name $tempRg -Location $location
        }

        It "Template $template and parameter file $parameterJson passes validation" {
            $ValidationResult = Test-AzureRmResourceGroupDeployment -ResourceGroupName $tempRg -Mode Complete -TemplateFile $template -TemplateParameterFile $parameterJson
            $ValidationResult | Should BeNullOrEmpty
        }

        AfterAll {
            Remove-AzureRmResourceGroup $tempRg -Force
        }
    }
    #>
}





