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

deploy () {
    currentPath=$(pwd)

    for sharedflow in "${target_sharedflows[@]}"
    do
        echo "> Deploy '$sharedflow'..."
        cd $currentPath/sharedflows/$sharedflow
        mvn install -P$profile -Dusername=$username -Dpassword=$password -Dhosturl=$hosturl -Dapiversion=$apiversion -Dorg=$org -Denv=$env -Doptions=$options -Doverride_delay=$override_delay -Ddelay=$delay
        echo
    done
}



input
. profile-$profile.config
deploy
