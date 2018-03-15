@echo off

if "%1" == "start" goto start
if "%1" == "end" goto shutdown
if "%1" == "workspace" goto workspace
if "%1" == "mysql" goto mysql
if "%1" == "mysql-shell" goto mysql-shell

goto end

:mysql
call docker-compose exec mysql mysql -uroot -proot "%2"
goto end

:mysql-shell
call docker-compose exec mysql bash
goto end


:workspace
call docker-compose exec --u=laradock workspace bash
goto end

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
