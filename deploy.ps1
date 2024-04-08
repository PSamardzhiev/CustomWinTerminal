function CheckStarshipInstallation {
    $starshipInstalled = (Get-Command starship -ErrorAction SilentlyContinue) -ne $null
    return $starshipInstalled
}

function InstallChocolatey {
    Write-Output "Chocolatey is not installed. Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

    # Check if Chocolatey installation was successful
    $chocoInstalled = (Get-Command choco -ErrorAction SilentlyContinue) -ne $null
    return $chocoInstalled
}

function InstallStarshipUsingChocolatey {
    Write-Output "Installing Starship using Chocolatey..."
    choco install starship -y

    # Check if Starship installation was successful
    $starshipInstalled = (Get-Command starship -ErrorAction SilentlyContinue) -ne $null
    return $starshipInstalled
}

# Check if Starship is installed
$starshipInstalled = CheckStarshipInstallation

if ($starshipInstalled) {
    Write-Output "Starship is already installed."
} else {
    Write-Output "Starship is not installed."
    
    # Check if Chocolatey is installed
    $chocoInstalled = (Get-Command choco -ErrorAction SilentlyContinue) -ne $null
    
    if (-not $chocoInstalled) {
        $chocoInstalled = InstallChocolatey
        if (-not $chocoInstalled) {
            Write-Output "Failed to install Chocolatey. Exiting..."
            exit
        } else {
            Write-Output "Chocolatey installation successful."
        }
    }
    
    $starshipInstalled = InstallStarshipUsingChocolatey
    if ($starshipInstalled) {
        Write-Output "Starship installation successful."
    } else {
        Write-Output "Failed to install Starship. Exiting..."
        exit
    }
}
