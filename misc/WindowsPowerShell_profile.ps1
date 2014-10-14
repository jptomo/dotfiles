# ì˙ñ{åÍê›íË
$OutputEncoding = [Text.Encoding]::Default
$ENV:LANG = "ja_JP.CP932"

# create function touch
Function touch($filename)
{
  New-Item $filename -itemType File
}

# vim
$Env:VIM = "<vim path>"
$Env:VIMRUNTIME = "$Env:VIM\vim74"
Set-Alias -name vi -value vim.exe
Set-Alias -name vim -value vim.exe

# plink
Set-Alias -name plink -value "<plink path>"

# make cert 
Set-Alias -name makecert -value "C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin\makecert.exe"
# If you modify this file. Run below command:
# PS > $cert = Get-ChildItem cert:\CurrentUser\My -codesigning
# PS > Set-AuthenticodeSignature Profile.ps1 $cert

# Python
$ENV:PIP_DOWNLOAD_CACHE = "$ENV:TMP\pip"
$ENV:DISTUTILS_USE_SDK = 1

<#
# Misrosoft Platform SDKs
& {
  param($script, $parameters)

  $tempFile = [IO.Path]::GetTempFileName()
  cmd.exe /E:ON /V:ON /T:0E /C " `"$script`" $parameters && set > `"$tempFile`" "
  Get-Content $tempFile | Foreach-Object {
    if($_ -match "^(.*?)=(.*)$") {
      Set-Item -Path "ENV:\$($matches[1])" -Value $matches[2]
    }
  }
  Remove-Item $tempFile
} "C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin\SetEnv.cmd" "/Release /x64 /win7"
$ENV:VS90COMNTOOLS = "$ENV:VS100COMNTOOLS"
& cmd /c "COLOR 07"   # êFÇñﬂÇ∑
#>

# ### SetUp PATH ###
$path = "C:\Users\USER\Documents\Scripts"        # user scripts
$path += ";$Env:VIM"                             # vim
$ENV:PATH = $path + ";$ENV:PATH"

Set-Location "$ENV:USERPROFILE\Documents"

Remove-Variable path
