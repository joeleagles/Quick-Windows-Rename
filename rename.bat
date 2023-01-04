@echo off


REM --> Script Made By Joel Eagles




REM  --> this will run the script as admin (stole this section from someone online)

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------  


echo Current PC Name=%computername%
echo What would you like to rename this computer to?
set /p NewCompName=
wmic computersystem where name="%computername%" call rename name="%NewCompName%"




echo Changes will take effect on next Boot.
:reprompt
echo would you like to restart now? (y/n)
set /p RESTARTP=
if "%RESTARTP%"=="y" (shutdown.exe /r /t 00 && EXIT)
if "%RESTARTP%"=="n" (EXIT) else (GOTO reprompt)
