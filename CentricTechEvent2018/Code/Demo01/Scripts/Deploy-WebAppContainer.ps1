# Deploy-WebAppContainer.ps1
# Use this script to deploy the ARM Template with parameter input file.
# Change variables before running deployment

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]$Location,
    [Parameter(Mandatory = $true)]
    [string]$ResourceGroupName,
    [Parameter(Mandatory = $true)]
    [string]$appServicePlanName,
    [Parameter(Mandatory = $true)]
    [string]$acrName,
    [Parameter(Mandatory = $true)]
    [string]$acrImageName,
    [Parameter(Mandatory = $true)]
    [string]$siteName,
    [Parameter(Mandatory = $true)]
    [string]$ARMTemplateFile
        
)

#region get ACR Admin user credentials
$ContainerAdminUser = Get-AzureRmContainerRegistryCredential -ResourceGroupName $ResourceGroupName -Name $acrName
#endregion

#region create ARM Template Parameter object
$parametersARM = @{}
$parametersARM.Add('resourceGroupLocation', $Location)
$parametersARM.Add('resourceGroupName', $ResourceGroupName)
$parametersARM.Add('appServicePlanName', $appServicePlanName)
$parametersARM.Add('acrName', $acrName)
$parametersARM.Add('siteName', $siteName)
$parametersARM.Add('acrUserName', $ContainerAdminUser.Username)
$parametersARM.Add('acrUserPassword', $ContainerAdminUser.Password)
$parametersARM.Add('acrImageName', $acrImageName)
#endregion

#region Deploy ARM Template
   
#region Deploy ARM Template with local Parameter file
$result = (New-AzureRMDeployment `
        -TemplateFile $ARMTemplateFile `
        -Location $Location `
        -TemplateParameterObject $parametersARM -Verbose -DeploymentDebugLogLevel All)
$result
#endregion

#endregion