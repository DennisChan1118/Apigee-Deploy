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

echo "> API Proxy Name:"
read apiproxy

echo "> Target Profile:"
read profile

mvnpath="./apiproxies/$apiproxy/"

echo "> Move to '$mvnpath'..."
cd $mvnpath
echo "> Deploy '$apiproxy'..."
mvn install -P$profile -Dusername=$username -Dpassword=$password -Doptions=clean
