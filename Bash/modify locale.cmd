@echo off
echo changement de locale :
set key=HKCU\Control Panel\International

for /F "skip=2 tokens=3" %%i in ('reg query "%key%" /v "sDecimal"') do set dec=%%i
for /F "skip=2 tokens=3" %%i in ('reg query "%key%" /v "sList"') do set sep=%%i

REM. echo Le separateur decimal est : "%dec%"
REM. echo Le separateur liste est : "%sep%"

if "%dec%"=="," (
	echo FRANCAIS vers ANGLAIS 
	reg add "%key%" /v "sDecimal" /d "." /f
	reg add "%key%" /v "sList" /d "," /f
) else (
	echo. ANGLAIS vers FRANCAIS 
	reg add "%key%" /v "sDecimal" /d "," /f
	reg add "%key%" /v "sList" /d ";" /f
)

for /F "skip=2 tokens=3" %%i in ('reg query "%key%" /v "sDecimal"') do set dec=%%i
for /F "skip=2 tokens=3" %%i in ('reg query "%key%" /v "sList"') do set sep=%%i
echo Le nouveau separateur decimal est : "%dec%"
echo Le nouveau separateur liste est : "%sep%"