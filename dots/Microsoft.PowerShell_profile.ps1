# cp932
#
# Init(Admin):
#   > Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
# Init:
#   > Install-Module -Name posh-git -Scope CurrentUser -Force -AllowClobber
#   > Install-Module -Name Pscx -Scope CurrentUser -Force -AllowClobber
#   > Install-Module -Name WintellectPowerShell -Scope CurrentUser -Force -AllowClobber
#

# Load posh-git example profile
. "$HOME\Documents\WindowsPowerShell\Modules\posh-git\profile.example.ps1"

# vim ‚ÌÝ’è
#$_vimPath = "$HOME\Documents\Application\vim80-kaoriya-win64-8.0.0039-20161016"
#$ENV:Path = "$_vimPath;" + $Env:Path
#Set-Alias -name vim -value "$_vimPath\vim.exe"

#Import-Module WintellectPowerShell
#Invoke-CmdScript -script "C:\Program Files (x86)\Microsoft Visual C++ Build Tools\vcbuildtools.bat" amd64

. "$HOME\misc\dotfiles\misc\Microsoft.PowerShell_profile.ps1"

Function Global:Prompt {
    $realLASTEXITCODE = $LASTEXITCODE
    $Host.UI.RawUI.ForegroundColor = "White"
    Write-Host $pwd.ProviderPath -NoNewLine -ForegroundColor Green
    $global:LASTEXITCODE = $realLASTEXITCODE
    Write-Host "`n" -NoNewLine -ForegroundColor "DarkGray"
    return "$(git_branch)$(hg_branch)[$(Get-Date -Format 'yyyy/mm/dd hh:mm:ss')] PS $(_get_pwd)`n> "
}
