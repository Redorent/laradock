#!/bin/bash

if [ -f ../redorent-api/.env ]; then
    echo "Existing .env found. Delete it before running this script."
    exit 1
fi

if [ ! -d ../redorent-configs ]; then
    echo "No 'redorent-configs' directory! Clone it before running this script."
    exit 1
fi

cp ../redorent-configs/envs/env-redorent-api-local ../redorent-api/.env

echo "Done."

