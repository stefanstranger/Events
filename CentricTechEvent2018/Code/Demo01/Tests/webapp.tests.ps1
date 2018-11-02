#Requires -Modules Pester
<#
.SYNOPSIS
    Tests if Web App is being deployed.
.EXAMPLE
    Invoke-Pester
.NOTES
    This file has been created as an example of using Pester to validate the deployed environment
#>

$endpointUrl = "https://centriciacdemo.azurewebsites.net"

Describe "Test Deployed WebApp" {

    Context "Test Web App web page" {
        It "Resolves the DNS name" {
            $res = Resolve-DnsName -Name ($endpointUrl.Substring(8))
            $res.IP4Address | Should -Match "((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"
        }
        It "Returns web page Title" {
            $res = Invoke-WebRequest -Uri ( '{0}/dashboard' -f $endpointUrl)
            ($res.content | convertfrom-json).dashboard.title | Should -Match 'Hello Centric'
        }
    }
}