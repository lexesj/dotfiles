# $PROFILE lives under Documents, which OneDrive may redirect, so it can't be a
# fixed chezmoi target. Point it at ~/.config/powershell/profile.ps1 instead.
$ProfilePath = $PROFILE.CurrentUserAllHosts
$Line = '. "$HOME\.config\powershell\profile.ps1"'

# Replace the symlink left by the old windows-dotfiles repo.
if ((Get-Item -Path $ProfilePath -ErrorAction SilentlyContinue).LinkType)
{
    Remove-Item -Path $ProfilePath
}

if (-not (Test-Path -Path $ProfilePath))
{
    New-Item -ItemType File -Path $ProfilePath -Force | Out-Null
}

if (-not (Select-String -Path $ProfilePath -SimpleMatch $Line -Quiet))
{
    Write-Host "Sourcing ~/.config/powershell/profile.ps1 from $ProfilePath..."
    Add-Content -Path $ProfilePath -Value $Line
}
