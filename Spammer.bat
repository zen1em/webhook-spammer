@echo off
setlocal enabledelayedexpansion
color 1
title Webhook Spammer - Zen Lucid
mode 110,25
chcp 65001 >nul

:----------------------------------------------------------------------------------------------------------------------
:menu

:::                [38;5;34m ██╗    ██╗██╗  ██╗    ███████╗██████╗  █████╗ ███╗   ███╗███╗   ███╗███████╗██████╗
:::                [38;5;35m ██║    ██║██║  ██║    ██╔════╝██╔══██╗██╔══██╗████╗ ████║████╗ ████║██╔════╝██╔══██╗
:::                [38;5;36m ██║ █╗ ██║███████║    ███████╗██████╔╝███████║██╔████╔██║██╔████╔██║█████╗  ██████╔╝
:::                [38;5;37m ██║███╗██║██╔══██║    ╚════██║██╔═══╝ ██╔══██║██║╚██╔╝██║██║╚██╔╝██║██╔══╝  ██╔══██╗
:::                [38;5;38m ╚███╔███╔╝██║  ██║    ███████║██║     ██║  ██║██║ ╚═╝ ██║██║ ╚═╝ ██║███████╗██║  ██║
:::                [38;5;39m  ╚══╝╚══╝ ╚═╝  ╚═╝    ╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝[0m

for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A

echo.
echo.
echo  [90m^>  [97m1. Spam webhook
echo  [90m^>  [97m2. Check webhook
echo  [90m^>  [97m3. Exit
echo.

set /p "choice=[90m > [97m Choice: "

if %choice%==1 (
  goto setwebhook
) else if %choice%==2 (
  goto checker
) else if %choice%==3 (
    exit
)
:------------------------------------------------------------------------------------

:setwebhook

cls
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A

echo.
echo.

set /p "webhook=[90m > [97m Webhook: "
set /p "message=[90m > [97m Message: "
set /p "username=[90m > [97m Bot username: "

set finalmessage=%message%
goto spamspamspam

:spamspamspam
cls
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A
echo.
echo.
echo  [90m^>  [97mSpamming..
set "payload={\"username\": \"%username%\", \"content\": \"%message%\"}"
FOR /L %%A IN (1,1,200) DO (
    ping 127.0.0.1 -n 1 -w 300 >nul

    for /f "delims=" %%a in ('curl -s -X POST -H "Content-Type: application/json" -d "%payload%" %webhook% -w "%%{http_code}" -o nul') do set status_code=%%a

    if "!status_code!" == "204" (
        echo  [90m^>  [97mMessage [32msent [97m
    ) else if "!status_code!" == "429" (
        echo  [90m^>  [97mWebhook has been [33mratelimited[97m
    ) else if "!status_code!" == "404" (
        echo  [90m^>  [97mMessage [31mfailed to send [97m
        timeout 5 >nul
        cls
        goto menu
    ) else if "!status_code!" == "000" (
        echo  [90m^>  [97mWebhook URL is [invalid [97m
        timeout 5 >nul
        cls
        goto menu
    ) else (
        echo  [90m^>  [97mStatus code is [31munknown [97m: !status_code!
    )
)
goto spamspamspam

:checker
cls
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A

echo.
echo.

set /p "webhook2=[90m > [97m Webhook: "
for /f "delims=" %%a in ('curl --silent --output NUL -w "%%{http_code}" -X GET "%webhook2%"') do set STATUS_CODE=%%a

echo  [90m^>  [97mChecking webhook..

if "%STATUS_CODE%" == "200" (
    echo  [90m^>  [97mWebhook is valid!
    timeout 5 >nul
    cls
    goto menu
) else (
  echo  [90m^>  [97mWebhook isn't valid!
    timeout 5 >nul
    cls
    goto menu
)
