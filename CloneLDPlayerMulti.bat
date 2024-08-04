@echo off
setlocal enabledelayedexpansion

cd C:\LDPlayer\LDPlayer9\vms

set /p id="Which instance do you want to clone? (Find the ID in LDMultiPlayer) "

if not exist leidian%id% (
    echo The ID %id% is not available.
    endlocal
    pause
    exit /b
)

set /p cloneCount="How many times do you want to clone this instance? "

set "baseName=leidian"

set maxNumber=-1

for /d %%f in (%baseName%*) do (
    :: Extract the number from the folder name
    set "folderName=%%~nxf"
    set "number=!folderName:%baseName%=!"

    :: Check if the number is greater than the current maxNumber
    if !number! gtr !maxNumber! (
        set maxNumber=!number!
    )
)

for /l %%i in (1, 1, %cloneCount%) do (
    set /a nextNumber=maxNumber+%%i
    mkdir %baseName%!nextNumber!
    xcopy /E /I %baseName%%id%\* %baseName%!nextNumber!\
    cd config
    copy %baseName%%id%.config %baseName%!nextNumber!.config
    cd ..
)

echo %cloneCount% LDPlayer Instance(s) Cloned

endlocal
pause
