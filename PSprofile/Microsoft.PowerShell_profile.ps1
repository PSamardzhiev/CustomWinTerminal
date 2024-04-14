Clear-Host
$aliasKeys = @("v,", "t,", "k,", "vs,", "py,", "rst,", "hvm,", "teleport <vm> <git>,")
$banner_text = "Welecome to your custom Windows Terminal Environment "
function Test-AdministratorPrivileges {
    $isAdmin = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")
    if ($isAdmin) {
        Write-Host -BackgroundColor Black -ForegroundColor Red "This PowerShell session is running with Administrator privileges."
    } else {
        Write-Host -BackgroundColor Black -ForegroundColor Green "This PowerShell session is NOT running with Administrator privileges " 
        
    }
}
Write-host ([char]9996 +"  ") -NoNewline
Write-Host $banner_text `n"Your data is located at: "$env:OneDriveConsumer -BackgroundColor Black -ForegroundColor Green
Write-Host "Logged-in username: $env:USERNAME" -BackgroundColor Black -ForegroundColor Green
Write-Host "Your computername: $env:COMPUTERNAME" -BackgroundColor Black -ForegroundColor Green
Write-Host "Some of your custom terminal functions:  $aliasKeys"
Test-AdministratorPrivileges

#load starship config
Invoke-Expression $(starship init powershell)
#end starship config loader
function rst { 
    Invoke-Command -ScriptBlock {
        Powershell.exe
    }
}
function teleport($fkey) {
    if ($fkey -eq "vm") { set-location -Path D:\LVMs}
    elseif ($fkey -eq "git") { Set-Location -Path 'D:\GIT Repos'}
}

foreach ($key in $aliasKeys) {
    switch ($key) {
        "v" { Set-Alias -Name $key -Value "vagrant" }
        "t" { Set-Alias -Name $key -Value "terraform" }
        "k" { Set-Alias -Name $key -Value "kubectl" }
        "vs" { Set-Alias -Name $key -Value "code" }
        "py" { Set-Alias -Name $key -Value "python3"}
        "hvm" { set-alias -Name $key -Value "virtmgmt.msc"}
    }
}