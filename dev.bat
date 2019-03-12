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
call docker-compose up -d --build %2
goto finish

:docker_restart
echo **** DOCKER ERROR
echo You need to restart docker service.
echo ****
goto end

:start
set MONGO_DATA_PATH=c:/Users/%USERNAME%/.laradock/data
call docker-compose up -d mysql nginx mongo phpmyadmin redis
if %ERRORLEVEL% neq 0 (goto error)
curl http://localhost:8000/api/hello
if %ERRORLEVEL% EQU 7 (goto docker_restart)
echo ''
goto workspace

:end
call docker-compose down
goto finish

:error
echo **** Docker container failed to start, shutting down.
goto end

:finish