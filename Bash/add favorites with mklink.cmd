@echo off
set /p a="Dossier a mettre en favori : "
set /p b="Nom du favori : "
set b=%userprofile%\Links\%b%
echo mklink /d "%b%" "%a%"
pause
mklink /d "%b%" "%a%"
