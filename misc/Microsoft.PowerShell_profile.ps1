# cp932
$OutputEncoding = [Text.Encoding]::Default
$ENV:LANG = "ja_JP.CP932"

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

Function Global:Prompt {
    $realLASTEXITCODE = $LASTEXITCODE
    $Host.UI.RawUI.ForegroundColor = "White"
    Write-Host $pwd.ProviderPath -NoNewLine -ForegroundColor Green
    $global:LASTEXITCODE = $realLASTEXITCODE
    Write-Host "`n" -NoNewLine -ForegroundColor "DarkGray"
    return "[$(Get-Date -Format 'yyyy/mm/dd hh:mm:ss')] `nPS> "
    # $git_b, $hg_b = git_branch, hg_branch
    # return "$($git_b)$($hg_b)[$(Get-Date -Format 'yyyy/mm/dd hh:mm:ss')] PS $(_get_pwd)`n> "
}

# vim
[Environment]::SetEnvironmentVariable("VIM", $null, "User")
[Environment]::SetEnvironmentVariable("VIMRUNTIME", $null, "User")
$ENV:Path = "C:\path\to\vim.exe;" + $Env:Path
Set-Alias -name vi -value vim.exe

# plink
#Set-Alias -name plink -value "<plink path>"

# Python
#$ENV:DISTUTILS_USE_SDK = 1
$ENV:PATHEXT += ";.PY"
# & "~\.local\venv\Scripts\activate.ps1"
#
# ### SetUp PATH ###

# ### SetUp PATH ###

# VS2015
#Import-Module WintellectPowerShell
#Invoke-CmdScript -script "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools\VsDevCmd.bat"
# adb
#$ENV:Path = "C:\Path\to\Android\sdk\platform-tools;" + $Env:Path

# Mingw64
Function Initialize-MinGW64()
{
    $ENV:MSYSTEM = "MINGW64"
    $ENV:MSYSCON = "path\to\Cmder.exe"
    $ENV:PATH += ";C:\msys64\mingw64\lib;C:\msys64\mingw64\bin"
    $ENV:MINGW_MOUNT_POINT = "C:\msys64\mingw64"
    $ENV:PKG_CONFIG_PATH = "${MINGW_MOUNT_POINT}\lib\pkgconfig;${MINGW_MOUNT_POINT}\share\pkgconfig"
    $ENV:ACLOCAL_PATH = "${MINGW_MOUNT_POINT}\share\aclocal;C:\msys64\usr\share\aclocal"
}

# something else
$ENV:PATH = [String]::Join(';', ($ENV:PATH -split ';' | ? {$_ -ne ''} | % {$_.Trim() -replace '/', '\'}))
$ENV:PATHEXT = [String]::Join(';', ($ENV:PATHEXT -split ';' | ? {$_ -ne ''} | % { $_.Trim().ToUpper() }))

#Import-Module Pscx

#Import-Module PoshUtil
#Import-Module PoshGit2

# PowerShell ReadLine
# see https://github.com/lzybkr/PSReadLine#installation
#Import-Module PSReadLine
#Set-PSReadlineOption -EditMode Emacs


Set-Alias -Name ngen -Value (Join-Path ([System.Runtime.InteropServices.RuntimeEnvironment]::GetRuntimeDirectory()) ngen.exe)
[AppDomain]::CurrentDomain.GetAssemblies() |
    where { ( $_.Location ) `
            -and -not $_.Location.Contains("PSReadLine.dll") `
            -and -not $_.Location.Contains("PSReadline.resources.dll") `
            -and -not $_.Location.Contains("Pscx3") `
            -and -not $_.Location.Contains("LibGit2Sharp.dll") `
            } |
    sort {Split-path $_.location -leaf} |
    %{
        $Name = (Split-Path $_.location -leaf)
        if ([System.Runtime.InteropServices.RuntimeEnvironment]::FromGlobalAccessCache($_))
        {
            # Write-Host "Already GACed: $Name"
        }else
        {
            Write-Host -ForegroundColor Yellow "NGENing      : $Name"
            ngen $_.location | %{"`t$_"}
         }
      }
