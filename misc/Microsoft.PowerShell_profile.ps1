# cp932
$OutputEncoding = [Text.Encoding]::Default
$ENV:LANG = "ja_JP.CP932"

# create function touch
Function touch()
{
  Param([string]$filename)

  Process {New-Item $filename -itemType File}
}

Function which()
{
  Param([string]$name)

  Process
  {
    $cmd = Get-Command $name
    $def = $cmd.Definition
    IF ($cmd.CommandType -ne 'Alias')
    {
      Write-Host $def
    }
    Else
    {
      Write-Host "(Alias) $def"
    }
  }
}

Function env()
{
  Process {Get-ChildItem ENV:}
}

function _reverse_check() {
  Param(
    $path,
    $dir_name
  )

  Process
  {
    $_path = $(Convert-Path -Path $path)
    $_root = $(Join-Path (Split-Path -Path $_path -Qualifier) '\')
    if (Test-Path (Join-Path $_path $dir_name)) {
      return $TRUE;
    } elseif ($_root -eq $_path) {
      return $FALSE;
    } else {
      $_parent = Split-Path -Path $_path -Parent
      _reverse_check $_parent $dir_name
    }
  }
}

function git_branch() {
  Process
  {
    if (-Not (_reverse_check $PWD.Path '.git'))
    {
      return
    }

    git branch 2>$null |
    ? { -not [System.String]::IsNullOrEmpty($_.Split()[0]) } |
    % { $bn = $_.Split()[1]
        Write-Output "(git:$bn) " }
  }
}

function hg_branch() {
  Process
  {
    if (-Not (_reverse_check $PWD.Path '.hg'))
    {
      return
    }

    hg branch 2>$null | % { Write-Output "(hg:$_) " }
  }
}

# return current directory
# with $ENV:HOME to ~
function _get_pwd() {
  $path = $(Get-Location).Path
  if ($path.IndexOf($ENV:HOME) -eq 0) {
    $path = Join-Path '~' ($PWD.ProviderPath.Remove(0, ($ENV:HOME).Length))
  }
  return $path
}

<#
function prompt {
  Process {
    $git_b = git_branch
    $hg_b = hg_branch
    # short home path
    return "$($git_b)$($hg_b)[$(Get-Date -Format 'yyyy/mm/dd hh:mm:ss')] PS $(_get_pwd)`n> "
  }
}
#>

# vim
[Environment]::SetEnvironmentVariable("VIM", $null, "User")
[Environment]::SetEnvironmentVariable("VIMRUNTIME", $null, "User")
$ENV:Path = "C:\path\to\vim.exe;" + $Env:Path
Set-Alias -name vi -value vim.exe

# plink
#Set-Alias -name plink -value "<plink path>"

# make cert 
#Set-Alias -name makecert -value "C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin\makecert.exe"
# If you modify this file. Run below command:
# PS > $cert = Get-ChildItem cert:\CurrentUser\My -codesigning
# PS > Set-AuthenticodeSignature Profile.ps1 $cert

# Python
#$ENV:DISTUTILS_USE_SDK = 1
$ENV:PATHEXT += ";.PY"

# SDKs
<# & {
  $script = "C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcvarsall.bat"
  $parameters = "amd64"
  $tempFile = [IO.Path]::GetTempFileName()
  cmd.exe /C " `"$script`" $parameters && SET > `"$tempFile`" "
  Get-Content $tempFile | % {
    if($_ -match "^(.*?)=(.*)$") {
      Set-Item -Path "ENV:\$($matches[1])" -Value $matches[2]
    }
  }
  Remove-Item $tempFile
} #>
<# & {
  $script = "C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin\SetEnv.cmd"
  $parameters = "/Release /x64 /win7"
  $tempFile = [IO.Path]::GetTempFileName()
  cmd.exe /E:ON /V:ON /T:0E /C " `"$script`" $parameters && SET > `"$tempFile`" "
  Get-Content $tempFile | % {
    if($_ -match "^(.*?)=(.*)$") {
      Set-Item -Path "ENV:\$($matches[1])" -Value $matches[2]
    }
  }
  Remove-Item $tempFile
} #>
<# & {
  $script = "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat"
  $parameters = "x86_amd64"
  $tempFile = [IO.Path]::GetTempFileName()
  cmd.exe /C " `"$script`" $parameters && SET > `"$tempFile`" "
  Get-Content $tempFile | % {
    if($_ -match "^(.*?)=(.*)$") {
      Set-Item -Path "ENV:\$($matches[1])" -Value $matches[2]
    }
  }
  Remove-Item $tempFile
} #>
# & cmd /c "COLOR 07"   # backup color

# ### SetUp PATH ###
#
# Python
# $ENV:MSSDK = "C:\Program Files\Microsoft SDKs\Windows\v7.1"
# & "~\.local\venv\Scripts\activate.ps1"

# something else
$cnv = {
  param($path)

  return $path
}
$ENV:PATH = ($ENV:PATH -split ";" | ? {$_ -ne ''} | % {$_.Trim() -replace "/", "\"}) -join ";"
$ENV:PATHEXT = ($ENV:PATHEXT -split ";" | ? {$_ -ne ''} | % {&$cnv $_.Trim().ToUpper()}) -join ";"

#Set-Location "~\Documents"

Remove-Variable path, cnv

# PowerShell ReadLine
# see https://github.com/lzybkr/PSReadLine#installation
#Import-Module PSReadLine
#Set-PSReadlineOption -EditMode Emacs

# :fenc=cp932 ff=dos:
# vim:ft=ps1 ts=2 sw=2 sts=2 fdl=0:
