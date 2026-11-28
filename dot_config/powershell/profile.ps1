# Loaded from $PROFILE.CurrentUserAllHosts by a stub that chezmoi writes.

# Only set up interactive consoles, not hosts like the VS Code extension.
if ($Host.Name -ne 'ConsoleHost')
{
    return
}

# Editor. --wait makes git and chezmoi block until the file is closed.
$env:EDITOR = "code --wait"
$env:SHELL = "pwsh"

# Prompt: [path] with git status, ending in "# " when elevated and "$ " otherwise.
Import-Module posh-git

$IsAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
$GitPromptSettings.BeforePath = "["
$GitPromptSettings.AfterPath = "]"
$GitPromptSettings.DefaultPromptSuffix = if ($IsAdmin) { " # " } else { " $ " }
$Host.UI.RawUI.WindowTitle = "PowerShell $($PSVersionTable.PSVersion)$(if ($IsAdmin) { ' [ADMIN]' })"
Remove-Variable IsAdmin

# Vi mode.
Import-Module PSReadLine
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineKeyHandler -Key Ctrl+d -Function ViExit

# fzf: Ctrl+T for files, Ctrl+R for history.
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# zoxide, replacing cd.
if (Get-Command zoxide -ErrorAction SilentlyContinue)
{
    Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
}
