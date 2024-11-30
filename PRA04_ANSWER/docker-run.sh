#!/bin/bash

ENV_VARS_TO_LOAD=$(bash util/clean-env-file.sh .env)
if [ $? -ne 0 ]; then
    exit 1
fi
if [ -z "$ENV_VARS_TO_LOAD" ]; then
    echo ".env file has no var defined!"
    exit 1
fi
while IFS== read -r key value; do
    printf -v "$key" %s "$value" && export "$key"
done <<< "${ENV_VARS_TO_LOAD}"

docker rm backend
docker rm frontend

docker run -d \
    --publish ${SPRING_PORT}:${SPRING_PORT} \
    --name backend \
    ${SPRING_TAG}":${SPRING_VER}"

docker run -d \
    --publish 90:${REACT_PORT} \
    --name frontend \
    ${REACT_TAG}":${REACT_VER}"

echo "backend and frontend running. To kill them use"
echo "docker kill backend"
echo "docker kill frontend"