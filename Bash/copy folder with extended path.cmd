@echo off
set /p a="Source : "
set /p b="Destination : "
echo robocopy /E "%a%" "%b%"
pause
call robocopy /E "%a%" "%b%"
echo.
pause