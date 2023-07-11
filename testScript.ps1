# Define the IP address and port number
$ipAddress = "192.168.1.110"
$port = 22

# Create a firewall rule to allow SSH traffic from the specified IP address
$ruleName = "Allow SSH from $ipAddress"
$ruleDescription = "Allow incoming SSH traffic from $ipAddress"
$ruleAction = "Allow"
$ruleDirection = "Inbound"
$ruleProtocol = "TCP"
$ruleLocalPort = $port.ToString()
$ruleRemoteAddress = $ipAddress

# Check if the firewall rule already exists
$existingRule = Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue

if ($existingRule -eq $null) {
    # Create a new firewall rule
    New-NetFirewallRule -DisplayName $ruleName -Description $ruleDescription -Action $ruleAction -Direction $ruleDirection -Protocol $ruleProtocol -LocalPort $ruleLocalPort -RemoteAddress $ruleRemoteAddress -Enabled True
    Write-Host "Firewall rule created successfully."
}
else {
    Write-Host "Firewall rule already exists."
}

# Create a scheduled task to delete the firewall rule after a specific duration (optional)
$taskName = "Delete Firewall Rule after 1 hour"
$taskDescription = "Deletes the firewall rule that allows SSH traffic from $ipAddress after 1 hour."
$actionScript = "Remove-NetFirewallRule -DisplayName `"$ruleName`" -ErrorAction SilentlyContinue"
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddHours(1)
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -Command `$actionScript"
Register-ScheduledTask -TaskName $taskName -Description $taskDescription -Trigger $trigger -Action $action -RunLevel Highest -Force
Write-Host "Scheduled task created successfully."
