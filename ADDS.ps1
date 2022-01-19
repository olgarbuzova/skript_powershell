$role = Install-WindowsFeature -Name "AD-Domain-Services" -IncludeManagementTools
if ($role.RestartNeeded -eq "Yes") { Restart-Computer -Force }
$password = ConvertTo-SecureString -String "WSadmin19AD" -AsPlainText -Force
Install-ADDSForest -DomainName "my.home.by" -SafeModeAdministratorPassword $password -InstallDns -Force