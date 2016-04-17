:: use this file to run your own startup commands
:: use @ in front of the command to prevent printing the command

:: @call "D:\tomo\Documents\Applications\cmder_mini_v1.2.9\vendor\git-for-windows/cmd/start-ssh-agent.cmd
:: @set PATH=%CMDER_ROOT%\vendor\whatever;%PATH%

@SET Path=D:\tomo\Documents\misc\cmd;D:\tomo\Documents\misc\venvs\pyvenv351\Scripts;D:\tomo\Documents\Applications\vim74-kaoriya-win64-20160305;C:\msys64\mingw64\bin;%Path%

:: for Python 3.4
:: "C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin\SetEnv.cmd" /Release /x64
:: COLOR 07

@prompt $E[1;32;40m$P$S{git}{hg}$S$_$E[1;30;40m$G$S$E[0m
