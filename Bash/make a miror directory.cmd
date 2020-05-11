@echo off
set /p a="Source : "
set /p b="Destination : "
call robocopy /E "%a%" "%b%" /E /PURGE /MIR /XO /W:1