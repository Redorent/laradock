#!/bin/bash

case "$1" in
end*)
	docker-compose down	
	;;	
*)
	IS_RUNNING=$(docker-compose ps | grep Up | grep workspace | wc -l)
	
	if [ "$IS_RUNNING" -eq 1 ];
	then
		docker-compose exec --u=laradock workspace bash
	else 
		export DATA_PATH_HOST=$HOME/.laradock/data
		export MONGO_DATA_PATH=$DATA_PATH_HOST
		docker-compose up -d
		if [ "$?" -eq 0 ];
		then
			docker-compose exec --u=laradock workspace bash
		fi 
	fi
esac

exit

