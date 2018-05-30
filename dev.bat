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
echo We're assuming you HAVE wget and docker...
call docker-compose up -d mysql nginx phpmyadmin
if %ERRORLEVEL% neq 0 (goto error)
echo "Finished."
wget -qO- http://localhost:8000/api/status
if %ERRORLEVEL% neq 0 (goto restart_docker)
goto end

:shutdown
call docker-compose down
goto end

:restart_docker
echo FFS, restart docker!
goto end

:error
echo **** Docker container failed to start, shutting down.
goto shutdown

:end
