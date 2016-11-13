# cp932
#
# Init(Admin):
#   > Install-Module -Scope CurrentUser -Name Pscx -RequiredVersion 3.2.1.0 -AllowClobber
# Init:
#   > Install-Module -Scope CurrentUser -Name posh-git -Force -AllowClobber
#   > Install-Module -Scope CurrentUser -Name Pscx -Force -AllowClobber
#

# Load posh-git example profile
. "$HOME\Documents\WindowsPowerShell\Modules\posh-git\profile.example.ps1"

# vim ÇÃê›íË
#$_vimPath = "$HOME\Documents\Application\vim80-kaoriya-win64-8.0.0039-20161016"
#$ENV:Path = "$_vimPath;" + $Env:Path
#Set-Alias -name vim -value "$_vimPath\vim.exe"

. "$HOME\misc\dotfiles\misc\Microsoft.PowerShell_profile.ps1"
