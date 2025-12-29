@echo off
cls

REM --- Argument check ---
if "%~1"=="" (
    echo Usage: %~nx0 ^<foldername^> [-asm] [description]
    exit /b 1
)

set FOLDER=
set TEXT=
set ONLY_ASSEMBLY=0
set PROGRAM_NAME=main

REM --- Parse arguments ---
:parse_args
if "%~1"=="" goto args_done

if "%~1"=="-asm" (
    set ONLY_ASSEMBLY=1
) else (
    if not defined FOLDER (
        set FOLDER=%~1
    ) else (
        if defined TEXT (
            set TEXT=%TEXT% %~1
        ) else (
            set TEXT=%~1
        )
    )
)
shift
goto parse_args

:args_done

set SRC=%FOLDER%\%PROGRAM_NAME%.c
set OUT=%FOLDER%\%PROGRAM_NAME%

REM --- Create folder ---
if not exist "%FOLDER%" mkdir "%FOLDER%"

set LABEL=Exercise
set EX_NUM=

REM --- Detect Chapter / Exercise ---
echo %FOLDER% | findstr /R /I "^CH[-]*[0-9.]*" >nul && (
    set LABEL=Chapter
    for /f "tokens=2 delims=-" %%a in ("%FOLDER%") do set EX_NUM=%%a
)

echo %FOLDER% | findstr /R /I "^E[-]*[0-9.]*" >nul && (
    set LABEL=Exercise
    for /f "tokens=2 delims=-" %%a in ("%FOLDER%") do set EX_NUM=%%a
)

REM --- Create C file if missing ---
if not exist "%SRC%" (
(
echo /*
echo   %LABEL% %EX_NUM%
echo   %TEXT%
echo */
echo.
echo #include ^<stdio.h^>
echo.
echo int main^(^) {
echo.
echo }
) > "%SRC%"

    echo File %SRC% created!
) else (
    echo File %SRC% already exists — skipping creation.
)

REM --- Compile ---
if %ONLY_ASSEMBLY%==1 (
    echo creating assembly file with debug info...
    gcc -S -g -fverbose-asm "%SRC%" -o "%OUT%.s"
    if errorlevel 1 goto asm_fail

    gcc -c "%OUT%.s" -o "%OUT%.o"
    gcc "%OUT%.o" -o "%OUT%.exe"
    "%OUT%.exe"

    echo ✅ assembly file created: %OUT%.s
    goto end
)

echo Compile %SRC%...
gcc "%SRC%" -o "%OUT%.exe"
if errorlevel 1 (
    echo ❌ Failed to compile.
    exit /b 1
)

"%OUT%.exe"

echo Compiled: %OUT%.exe
goto end

:asm_fail
echo ❌ Failed to create assembly file.
exit /b 1

:end
