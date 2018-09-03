#WinRM
#at first, you should run "winrm set winrm/config/client '@{TrustedHosts="xxx.xxx.xxx"} E command.

$scriptPath = Split-Path -Parent ($MyInvocation.MyCommand.Path)
$configScript = Join-Path $scriptPath "Config.ps1"
. $configScript

# Get Password
$passwordFile = Join-Path $scriptPath "password.txt"
if((Test-Path $passwordFile) -eq $false){
    Write-Host "generate password file to $passwordFile ."
    $credential = Get-Credential -UserName "cloudadmin" -Message "Plase type password of cloudadmin."
    $credential.Password | ConvertFrom-SecureString | Set-Content $passwordFile
} else {
    Write-Host "using password from $passwordFile ."
}

# Create Credentials for CloudAdmin
$password = Get-Content $passwordFile | ConvertTo-SecureString
$credential = New-Object System.Management.Automation.PSCredential $cloudadminUserName,$password

# Create session to PEP
$session = New-PSSession -ComputerName $ErcsVmIP -ConfigurationName PrivilegedEndpoint -Credential $credential

# Invoke Commands
# Test-AzureStack
$resultTestAzureStack = Invoke-Command -session $session -ScriptBlock {
    Test-AzureStack
}

if($resultTestAzureStack) {
    $body = ConvertTo-Json @{
        text = "All Success"
        title = "Result of Test-Azure Stack"
    }
} else {
    $body = ConvertTo-Json @{
        text = '<font color="Red">Failed</font>'
        title = "Result of Test-Azure Stack"
    }
}
Invoke-RestMethod -uri $NotificationURI -Method Post -body $body -ContentType 'application/json'

