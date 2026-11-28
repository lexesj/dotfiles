# Bootstraps the dotfiles on Windows. Runs in Windows PowerShell 5.1 or PowerShell 7.
# Installs what chezmoi needs before it can apply (git to clone, pwsh to run the
# .ps1 scripts), then initializes and applies the repo.

$ErrorActionPreference = "Stop"

foreach ($Id in @("Git.Git", "Microsoft.PowerShell", "twpayne.chezmoi"))
{
    winget list --id $Id --exact --accept-source-agreements *> $null
    if ($LASTEXITCODE -ne 0)
    {
        Write-Host "Installing $Id..."
        winget install --id $Id --exact --silent --accept-source-agreements --accept-package-agreements
    }
}

# Pick up the PATH changes from the installs above.
$env:Path = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [Environment]::GetEnvironmentVariable("Path", "User")

chezmoi init --apply https://github.com/lexesj/dotfiles.git
