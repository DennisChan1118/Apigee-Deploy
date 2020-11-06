#!/bin/bash

# Run this command to rollback Sharedflow to previous revision.

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

undeploy () {
    for sharedflow in "${target_sharedflows[@]}"
    do
        revisions_resp=$(curl -u "$username:$password" "$hosturl/$apiversion/organizations/$org/sharedflows/$sharedflow/revisions")
        revisions=( $(tr -d "[],\"" <<< "${revisions_resp}") )

        current_deployment_resp=$(curl -u "$username:$password" "$hosturl/$apiversion/organizations/$org/environments/$env/sharedflows/$sharedflow/deployments")
        current_revision=$(jq -r .revision[0].name <<< "${current_deployment_resp}") 

        if [ "${#revisions[@]}" -gt 1 ]; then
            if [ "${revisions[${#revisions[@]} - 1]}" == "$current_revision" ]; then
                stable_revision=${revisions[${#revisions[@]} - 2]}
            else
                stable_revision=${revisions[${#revisions[@]} - 1]}
            fi
        fi

        echo -e "\nUndeploy shared flow $sharedflow (revision $current_revision)"
        curl -X DELETE -u $username:$password "$hosturl/$apiversion/organizations/$org/environments/$env/sharedflows/$sharedflow/revisions/$current_revision/deployments"
        curl -X DELETE -u $username:$password "$hosturl/$apiversion/organizations/$org/sharedflows/$sharedflow/revisions/$current_revision"
        echo

        if [ ! -z "$stable_revision" ]; then
            echo -e "\nRollback to revision $stable_revision"
            curl -X POST -u $username:$password -H "Content-Type: application/x-www-form-urlencoded" "$hosturl/$apiversion/organizations/$org/environments/$env/sharedflows/$sharedflow/revisions/$stable_revision/deployments"
            echo
        fi
    done
}



input
. profile-$profile.config
undeploy
