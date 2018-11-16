@echo off

goto %1
goto finish

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
goto finish

:mysql_shell
call docker-compose exec mysql bash
goto finish

:mongo
call docker-compose exec mongo mongo
goto finish

:workspace
call docker-compose exec --u=laradock workspace bash
goto finish

:build %2
set DATA_PATH_HOST=C:\Users\%USERNAME%\.laradock/data
set MONGO_DATA_PATH=c:/Users/%USERNAME%/.laradock/data
call docker-compose up -d %2
goto finish

:start
set DATA_PATH_HOST=.laradock/data2
call docker-compose up -d mongo mysql nginx mongo phpmyadmin
if %ERRORLEVEL% neq 0 (goto error)
goto workspace

:end
docker-compose down
goto finish

:error
echo **** Docker container failed to start, shutting down.
goto finish

:finish