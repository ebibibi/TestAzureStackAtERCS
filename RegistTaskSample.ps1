$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-File 'c:\AzureStackOperationScripts\TestAzureStackAtERCS\Test-AzureStackAtERCS.ps1'"
$trigger = New-ScheduledTaskTrigger -DaysInterval 1 -Daily -At "7:00 AM"
$settings = New-ScheduledTaskSettingsSet -Compatibility Win8 -Hidden
Register-ScheduledTask -TaskPath \ -TaskName TestAzureStackAtERCS -Action $action -Trigger $trigger -Settings $settings