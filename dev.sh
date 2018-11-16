#!/bin/bash

case "$1" in
start*)
	docker-compose up -d --build phpmyadmin mysql nginx mongo
	if [ "$?" -eq 0 ];
	then
		docker-compose exec --u=laradock workspace bash
	fi 
	;;
end*)
	docker-compose down
	;;
mongo*)
	docker-compose exec mongo mongo
	;;
workspace*)
	docker-compose exec --u=laradock workspace bash
	;;
*)
	echo $"Usage: $0 {start|end|mongo|workspace}"
	exit 1
esac

exit

