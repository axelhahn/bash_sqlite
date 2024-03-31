#!/bin/bash

# --------------------------------------------------------------------
# init
# --------------------------------------------------------------------

cd "$(dirname "$0" )" || exit 1

# shellcheck disable=SC1091
. ../vendor/ini.class.sh || exit 1

# shellcheck disable=SC1091
. ../sqlite.class.sh || exit 1

# --------------------------------------------------------------------
# functions
# --------------------------------------------------------------------

# dump a given hash
# param 1: hash name
function dumpHash(){
    local _key

    local _varname=$1
    local -n _hash=$1
    if [ "${_hash[*]}" = "" ] ; then
        echo "INFO: $_varname is no hash"
    else
        echo "$_varname = ["
        for _key in "${!_hash[@]}"; do
            echo "  $_key => ${_hash[$_key]}"
        done
        echo "]"
    fi
}

function h2(){
    echo; echo ">>>>>>>>>> $*"; echo
}

# --------------------------------------------------------------------
# main
# --------------------------------------------------------------------

dbfile=$( ini.value "./example.ini" sqlite file )
echo "dbfile = $dbfile"
test -f "$dbfile" && echo "INFO: Deleting example db $dbfile"  }
test -f "$dbfile" && rm -f "$dbfile" 


# sqlite.debugOn

h2 "create a new database using [example.ini]"
# sqlite.debugOn
sqlite.ini "./example.ini"

# show tables
echo "--- tables"
sqlite.tables
echo

echo "--- colums if table 'users'"
sqlite.columnlist "users"
sqlite.columnlist
echo

h2 "create a first record"

echo "--- create an empty dataset 'oUser' with keys from table 'users'"
sqlite.newvar 'users' 'oUser'
eval "$( sqlite.newvar 'users' 'oUser' )"
dumpHash "oUser"


echo "(1) You can modify its values"
echo "(2) execute sqlite.save 'oUser' to save it to the database as new record."
echo

# echo "Keys: ${!oUser[*]}"
# echo "Values: ${oUser[*]}"

oUser['username']='testuser1'
oUser['firstname']='Axel'
oUser['lastname']='Hahn'
dumpHash "oUser"
echo
sqlite.save "oUser"
echo
sqlite.rows 'users'
sqlite.rowcount 'users'



h2 "create a 2nd record"

oUser['username']='testuser2'
oUser['firstname']='John'
oUser['lastname']='Doe'
dumpHash "oUser"
echo
sqlite.save "oUser"
echo

# lease notice: ther is no table name as param
sqlite.rows
sqlite.rowcount


h2 "read user id 2"

eval "$( sqlite.read users 2 oUser )"
# sqlite.debugOff
dumpHash "oUser"

h2 "update user id 2: John Doe --> John Smith"

oUser['lastname']='Smith'
dumpHash "oUser"
sqlite.update "oUser"

sqlite.rows


h2 "delete user"
dumpHash "oUser"
sqlite.delete "oUser"
sqlite.rows

# --------------------------------------------------------------------
