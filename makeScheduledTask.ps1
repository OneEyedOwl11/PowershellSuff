$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument ''

$trigger = New-ScheduledTaskTrigger -Daily -At 9am

Register-ScheduledTast -Action $action -Trigger $trigger -TaskName "Totally not malitious xD" -Description "Test purposes"