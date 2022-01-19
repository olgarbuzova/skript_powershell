Install-WindowsFeature -Name "DHCP" -IncludeManagementTools
Add-DhcpServerSecurityGroup
Add-DhcpServerv4Scope -Name "virtual" -StartRange "10.0.0.1" -EndRange "10.0.0.254" -SubnetMask "255.255.255.0" -LeaseDuration "8.00:00:00"
$scope = Get-DhcpServerv4Scope -ScopeId "10.0.0.0"
Add-DhcpServerv4Reservation -IPAddress "10.0.0.2" -ScopeId $scope.ScopeId -ClientId "00-15-5D-01-68-03"
Set-DhcpServerv4OptionValue -ScopeId "10.0.0.0" -DnsServer "10.0.0.12" -DnsDomain "my.home.by"
Add-DhcpServerInDC
Restart-Service "DHCP"
