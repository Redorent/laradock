@echo off

if "%1" == "start" goto start
if "%1" == "end" goto shutdown
if "%1" == "workspace" goto workspace
if "%1" == "mysql" goto mysql
if "%1" == "mongo" goto mongo
if "%1" == "mysql-shell" goto mysql-shell
if "%1" == "test" goto test
goto help

:help
echo Usage:
echo   dev.bat (argument)
echo      start     - startup redorent api development environment
echo      end       - shutdown dev. environment
echo      workspace - enter development container
echo      mysql     - enter mysql container and perform SQL queries
echo      mongo     - run mongo queries

goto end

:mysql
call docker-compose exec mysql mysql -uroot -proot "%2"
goto end

:mysql-shell
call docker-compose exec mysql bash
goto end

:mongo
call docker-compose exec mongo mongo
goto end

:workspace
call docker-compose exec --u=laradock workspace bash
goto end

:start
call docker-compose up -d mysql nginx phpmyadmin mongo
if %ERRORLEVEL% neq 0 (goto error)

where /q wget
IF ERRORLEVEL 1 (
    ECHO You don't have WGET installed, I cannot check if BE is running or not.
)
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

:test
:end
echo.