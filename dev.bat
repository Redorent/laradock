@echo off

if "%1" == "start" goto start
if "%1" == "end" goto shutdown
if "%1" == "workspace" goto workspace


goto end


:workspace
call docker-compose exec --u=laradock workspace bash

:start
call docker-compose up -d mysql nginx phpmyadmin
if %ERRORLEVEL% neq 0 (goto error)
echo "Finished."
goto end

:shutdown
call docker-compose down
goto end

:error
echo "**** Docker container failed to start, shutting down."
goto shutdown

:end
