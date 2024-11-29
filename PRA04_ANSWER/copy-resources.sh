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


rm -rf "${SPRING_DIR}"
mkdir -p "${SPRING_DIR}"
cp ../Resources/SpringBoot_projects/BooksPageable-0.0.4-SNAPSHOT.jar "${SPRING_DIR}"/"${SPRING_JAR}".jar

rm -rf "${REACT_DIR}"
mkdir -p "${REACT_DIR}"
tar -xvzf ../Resources/React_projects/dist.tar.gz  --strip-components 1 --directory "${REACT_DIR}"
