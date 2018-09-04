#Unregister-ScheduledTask -TaskName TestAzureStackAtERCS

$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument '-ExecutionPolicy Bypass -File "C:\AzureStackOperationScripts\TestAzureStackAtERCS\Test-AzureStackAtERCS.ps1"'
$trigger = New-ScheduledTaskTrigger -DaysInterval 1 -Daily -At "7:00 AM"
$settings = New-ScheduledTaskSettingsSet -Compatibility Win8
Register-ScheduledTask -TaskPath \ -TaskName TestAzureStackAtERCS -Action $action -Trigger $trigger -Settings $settings -User administrator -Password yourpassword

#Start-ScheduledTask -TaskName TestAzureStackAtERCS
#Get-ScheduledTaskInfo -TaskName TestAzureStackAtERCS
