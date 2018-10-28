<#
    Demo Pester for ARM Template verification
#>

$params = @{
    TemplatePath = 'C:\Users\stefstr\Documents\GitHub\Events\CentricTechEvent2018\Code\Demo01\Templates\WebAppContainer.json'
    parameters   = 'resourceGroupLocation', 'resourceGroupName', 'appServicePlanName', 'acrName', 'siteName', 'acrImageName', 'acrUserName', 'acrUserPassword', 'port', 'hostNameSslStates'
    variables    = 'hostingPlanName', 'acrUrl', 'linuxFxVersion'
    resources    = 'Microsoft.Resources/resourceGroups', 'Microsoft.Resources/deployments'
    outputs      = 'imageNameOutput', 'dockerRegistryUrlOutput', 'linuxFxVersionOutput'
}

.\armtemplate.test.ps1 @params
