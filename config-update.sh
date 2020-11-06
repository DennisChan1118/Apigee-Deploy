#!/bin/bash

input () {
    if [ -n "$username" ]; then
        echo "> Username:"
        echo $username
    else
        echo "> Username:"
        read username
    fi

    if [ -n "$password" ]; then
        echo "> Password:"
        echo "*****"
    else
        echo "> Password:"
        read -s password
    fi

    echo "> Target Profile:"
    read profile
}

update () {
    mvnpath="./configs/$target_config"

    echo "> Move to '$mvnpath'..."
    cd $mvnpath
    echo "> Update Edge Config '$target_config'..."
    mvn install -P$profile -Doptions=update -Dusername=$username -Dpassword=$password -Dhosturl=$hosturl -Dapiversion=$apiversion -Dorg=$org -Denv=$env
}



input
. profile-$profile.config
update
