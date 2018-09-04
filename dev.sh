#!/bin/bash

if [ "$1" == "start" ];
	then
	docker-compose up -d --build mysql nginx phpmyadmin
	exit
fi

if [ "$1" == "end" ];
	then
		docker-compose down
		exit
fi

if [ "$1" == "workspace" ];
	then
	docker-compose exec --u=laradock workspace bash
	exit
fi

