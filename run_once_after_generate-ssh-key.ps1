$SshKey = "$HOME\.ssh\id_ed25519"

Write-Host "Checking ~/.ssh/id_ed25519..."

if (-not (Test-Path -Path $SshKey -PathType Leaf))
{
    $DefaultComment = "$env:USERNAME@$([System.Net.Dns]::GetHostName())-windows"
    $Comment = Read-Host -Prompt "SSH key comment [$DefaultComment]"
    if ([string]::IsNullOrWhiteSpace($Comment))
    {
        $Comment = $DefaultComment
    }

    Write-Host "Generating new SSH key with comment: $Comment"
    New-Item -ItemType Directory -Path "$HOME\.ssh" -Force | Out-Null
    ssh-keygen -t ed25519 -C $Comment -f $SshKey

    Write-Host "--------------------------------------------------------"
    Write-Host "SSH key generated successfully!"
    Write-Host "Public key (copy this to GitHub/GitLab):"
    Get-Content -Path "$SshKey.pub"
    Write-Host "--------------------------------------------------------"
    Read-Host -Prompt "Press Enter to continue..."
}
