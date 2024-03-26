#!/bin/bash

cd "$(dirname "$0" )" || exit 1

# shellcheck disable=SC1091
. ../vendor/ini.class.sh || exit 1

# shellcheck disable=SC1091
. ../sqlite.class.sh || exit 1


# dump a given hash
# param 1: hash name
function dumpHash(){
    local _key

    local _varname=$1
    local -n _hash=$1
    echo "$_varname = ["
    for _key in "${!_hash[@]}"; do
        echo "  $_key => ${_hash[$_key]}"
    done
    echo "]"
}

sqlite.ini "./example.ini"

# show tables
echo "--- tables"
sqlite.tables
echo

# --- 
# show colums if table 'users'
# sqlite.columns "users"


# --- 
# # create a var "oUser" with keys from table "users"
# eval $( sqlite.newvar "users" "oUser" )

# echo "Keys: ${!oUser[*]}"
# echo "Values: ${oUser[*]}"

# oUser['username']='axel'
# oUser['firstname']='Alex'
# oUser['lastname']='Hahn'
# dumpHash "oUser"
# sqlite.save "oUser"


# --- 
# # update test
# declare -A oUser
# oUser['id']=1
# oUser['__table__']=users
# oUser['firstname']='Axel2'
# sqlite.save "oUser"

# id="$( sqlite.getid users "username='axel'" )"
# echo id=$id

echo "--- 1st user:"
# sqlite.debugOn
eval "$( sqlite.read users 1 oUser )"
# sqlite.debugOff
dumpHash "oUser"
# sqlite.debugOn
# sqlite.delete "oUser"

# sqlite.deleteById 2 "users"