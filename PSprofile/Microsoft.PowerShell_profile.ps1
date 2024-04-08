Clear-Host
$aliasKeys = @("v", "t", "k", "vs", "py", "rst", "hvm")
$banner_text = "Welecome to your custom Windows Terminal Environment"
Write-Host $banner_text `n"Your data is located at: "$env:OneDriveConsumer -BackgroundColor Black -ForegroundColor Green
Write-Host "Logged-in username: $env:USERNAME" -BackgroundColor Black -ForegroundColor Green
Write-Host "Your computername: $env:COMPUTERNAME" -BackgroundColor Black -ForegroundColor Green
Write-Host "Some of your custom terminal functions: `n $aliasKeys"

#load starship config
Invoke-Expression $(starship init powershell)
#end starship config loader
function rst { 
    Invoke-Command -ScriptBlock {
        Powershell.exe
    }
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