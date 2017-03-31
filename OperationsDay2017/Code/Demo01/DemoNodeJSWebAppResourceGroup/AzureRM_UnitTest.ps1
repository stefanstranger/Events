#
# AzureRM_UnitTest.ps1
#

Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $ResourceGroupName)

#region Get-AzureRMResource
Find-AzureRmResource -ResourceGroupNameContains $ResourceGroupName | Measure-Object
#endregion

#region Testing number of Resources
$NumberOfResources = Find-AzureRmResource -ResourceGroupNameContains $ResourceGroupName | Measure-Object
'Number of Resources: {0}' -f $NumberOfResources.Count

$NumberOfResourcesCount = $NumberOfResources.count -eq 18
if (!($NumberOfResourcesCount))
{
    throw "Oops!! Something is wrong with the number of Resources in the ResoureGroup"
}
#endregion

#region Testing number of Websites
$NumberOfWebApps = Find-AzureRmResource -ResourceGroupNameContains $ResourceGroupName -ResourceType 'Microsoft.Web/sites' | Measure-Object
'Number of Azure WebApps: {0}' -f $NumberOfWebApps.Count

$NumberOfWebAppsCount = $NumberOfWebApps.count -eq 1
if (!($NumberOfResourcesCount))
{
    throw "Oops!! Something is wrong with the number of WebApps in the ResoureGroup"
}
#endregion