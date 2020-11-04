#!/bin/bash

if [ -n "$username" ]
then
    echo "> Username:"
    echo $username
else
    echo "> Username:"
    read username
fi

if [ -n "$password" ]
then
    echo "> Password:"
    echo "*****"
else
    echo "> Password:"
    read -s password
fi

echo "> Edge Config Name:"
read config

echo "> Target Profile:"
read profile

mvnpath="./configs/$config"

echo "> Move to '$mvnpath'..."
cd $mvnpath
echo "> Sync Edge Config '$config'..."
mvn install -P$profile -Dusername=$username -Dpassword=$password -Doptions=sync
