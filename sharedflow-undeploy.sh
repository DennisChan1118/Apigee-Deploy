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

echo "> Sharedflow Name:"
read sharedflow

echo "> Target Profile:"
read profile

mvnpath="./sharedflows/$sharedflow/"

echo "> Move to '$mvnpath'..."
cd $mvnpath
echo "> Deploy '$sharedflow'..."
mvn install -P$profile -Dusername=$username -Dpassword=$password -Doptions=clean
