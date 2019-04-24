#!/bin/bash

case "$1" in
start*)
	export DATA_PATH_HOST=$HOME/.laradock/data
	export MONGO_DATA_PATH=$DATA_PATH_HOST
	docker-compose up -d
	if [ "$?" -eq 0 ];
	then
		docker-compose exec --u=laradock workspace bash
	fi 
	;;
end*)
	docker-compose down	
	;;
workspace*)
	docker-compose exec --u=laradock workspace bash
	;;
*)
	docker-compose exec "$1" bash
	echo $"Usage: $0 {start|end|mongo|workspace}"
	exit 1
esac

exit

