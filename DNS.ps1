Install-WindowsFeature -Name "DNS" -IncludeManagementTools
$forwardZone = Get-DnsServerZone -Name "my.home.by" -ErrorAction SilentlyContinue
if ($forwardZone -eq $null) {
    Add-DnsServerPrimaryZone -Name "my.home.by" -ZoneFile "my.home.by.dns" -DynamicUpdate NonsecureAndSecure
}
$reversZone = Get-DnsServerZone -Name "0.0.10.in-addr.arpa" -ErrorAction SilentlyContinue
if ($reversZone -eq $null) {
    Add-DnsServerPrimaryZone -NetworkId "10.0.0.0/24" -ZoneFile "0.0.10.in-addr.arpa.dns" -DynamicUpdate NonsecureAndSecure
}
$resourceRecord = Get-DnsServerResourceRecord -ZoneName "my.home.by" -Name "win10-vm" -ErrorAction SilentlyContinue
if ($resourceRecord -eq $null) {
    Add-DnsServerResourceRecordA -Name "win10-vm" -ZoneName "my.home.by" -IPv4Address "10.0.0.2" -CreatePtr
}
Restart-Service "DNS"