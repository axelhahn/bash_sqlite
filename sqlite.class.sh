#!/bin/bash
# ======================================================================
#
# SQLITE HELPER FUNCTIONS
#
#  Author:  Axel hahn
#  License: GNU GPL 3.0
#  Source:  https://github.com/axelhahn/???/
#  Docs:    https://www.axel-hahn.de/docs/??/
#
# ----------------------------------------------------------------------
# 2024-03-22  v0.01  initial version
# 2024-03-29  v0.02  add "unset" to given var 
# 2024-04-01  v0.03  update params in all functions
# ======================================================================

# ----------------------------------------------------------------------
# VARIABLES
# ----------------------------------------------------------------------
BSQLITE_SELF="$( basename "$0" )"
BSQLITE_FILE=
BSQLITE_TABLE=

BSQLITE_READONLY=0
BSQLITE_MODE=

BSQLITE_ID="id"
BSQLITE_TABLENAME="__table__"

BSQLITE_DEBUG=0

# ----------------------------------------------------------------------
# FUNCTIONS :: DEGUGGING
# ----------------------------------------------------------------------

# write debug output to STDERR if BSQLITE_DEBUG is 1
# param  string  text to show
function sqlite._wd(){
    test $BSQLITE_DEBUG -ne 0 && echo "$BSQLITE_SELF: $*" >&2
}

# Disable debugging: turn off additional output
# see also: sqlite.debugOn()
function sqlite.debugOff(){
    sqlite._wd "${FUNCNAME[0]}()"
    BSQLITE_DEBUG=0
}
# Enable debugging: show more output on STDERR
# see also: sqlite.debugOff()
function sqlite.debugOn(){
    BSQLITE_DEBUG=1
    sqlite._wd "${FUNCNAME[0]}()"
}


# ----------------------------------------------------------------------
# low level functions


# Execute a given sql query on the given file
# see also: sqlite.queryRO()
#
# global  string  BSQLITE_FILE  file to execute the query on
#
# param   string  optional: (can be skipped) file
# param   string  query
function sqlite.query(){
    local _file
    local _query

    sqlite._wd "${FUNCNAME[0]}($*)"
    if [ -n "$2" ]; then
        _file="$1"
        _query="$2"
    else
        _file="$BSQLITE_FILE"
        _query="$1"
    fi
    sqlite._wd "${FUNCNAME[0]}() FILE=$_file"
    sqlite._wd "${FUNCNAME[0]}() QUERY=$_query"

    local _options="-batch "
    test "$BSQLITE_READONLY" -eq "1" && _options+="-readonly "
    test -n "$BSQLITE_MODE"          && _options+="-$BSQLITE_MODE "

    if ! sqlite3 $_options "$_file" "$_query"; then
        echo "SQL QUERY FAILED"
        exit 2
    fi
}

# Readonly query: it sets a readonly flag for the sqlite binary to execute the
# given query with readonly access
# see also: sqlite.query()
#
# global  string  BSQLITE_FILE  file to execute the query on
#
# param   string  optional: (can be skipped) file
# param   string  query
function sqlite.queryRO(){
    BSQLITE_READONLY=1
    sqlite.query "$1" "$2"
    BSQLITE_READONLY=0
}

# ----------------------------------------------------------------------
# init functions
# ----------------------------------------------------------------------

# Read the given ini file and create the tables if file does not exist yet
# It calls sqlite.setfile <FILE> to set a default sqlite file
#
# param  string  filename of ini file
function sqlite.ini(){
    local _inifile="$1"
    local _dbtable
    local _sql

    sqlite._wd "${FUNCNAME[0]}($*)"

    # sqlite._wd "${FUNCNAME[0]}($*)"
    test -f "$_inifile" || { echo "ERROR: File does not exist: $_inifile"; return 1; }
    BSQLITE_FILE=$( ini.value "$_inifile" "sqlite" "file" )
    sqlite.setfile "$BSQLITE_FILE"

    ini.sections "$_inifile" | grep "^table\." | while read -r section; do
        _dbtable=${section//table\./}

        sqlite._wd "${FUNCNAME[0]} Test table '$_dbtable' ..."
        if ! sqlite.tableexists "$_dbtable"; then

            sqlite._wd "${FUNCNAME[0]} Table '$_dbtable' does not exist yet"
            _sql=""
            sqlite._wd "INI section: $section --> $_dbtable"

            for mykey in $( ini.keys "$_inifile" "$section" )
            do
                _val=$( ini.value "$_inifile" "$section" "$mykey" )
                sqlite._wd "   $_dbtable .. $mykey = $_val"
                test -n "$_sql" && _sql+=', '
                _sql+="$mykey $_val"
            done
            _sql="CREATE TABLE $_dbtable ($_sql);"
            sqlite.query "$_sql" || exit 1
        else
            sqlite._wd "${FUNCNAME[0]} Table '$_dbtable' already exists"
        fi

    done
}

# Set the sqlite file and current table name
# You can set its parameters individually too:
# see also: sqlite.setfile
# see also: sqlite.settable
#
# param  string  filename
# param  string  table name
function sqlite.init(){
    sqlite._wd "${FUNCNAME[0]}($*)"
    sqlite.setfile "$1"
    sqlite.settable "$2"
}


# ----------------------------------------------------------------------
# information functions
# ----------------------------------------------------------------------

# Show columns of a table each in a single line
#
# global  string  BSQLITE_FILE   file to execute the query on
# global  string  BSQLITE_TABLE  current table name
#
# param   string  optional: (can be skipped) sqlite file
# param   string  optional: (can be skipped) table name
function sqlite.columnlist(){
    local _file
    local _table
    local _delim
    _delim=","
    sqlite._wd "${FUNCNAME[0]}($*)"

    if [ -n "$2" ]; then
        sqlite.setfile "$1"
        sqlite.settable "$2"
    else
        test -n "$1" && sqlite.settable "$1"
    fi

    # sqlite3 example.db "SELECT GROUP_CONCAT(NAME,',') FROM PRAGMA_TABLE_INFO('users')"
    sqlite.queryRO "$BSQLITE_FILE" "SELECT GROUP_CONCAT(NAME, '${_delim}') FROM PRAGMA_TABLE_INFO('${BSQLITE_TABLE}')"
}

# Show columns of a table seperated with comma
#
# global  string  BSQLITE_FILE   file to execute the query on
# global  string  BSQLITE_TABLE  current table name
#
# param   string  optional: (can be skipped) sqlite file
# param   string  optional: (can be skipped) table name
function sqlite.columns(){
    sqlite.columnlist "$1" "$2" | tr ',' "\n"
}

# show tables of current sqlite file each in a single line
#
# global  string  BSQLITE_TABLE  current table name
#
# param   string  optional: sqlite file
function sqlite.tables(){
    sqlite._wd "${FUNCNAME[0]}($*)"
    test -n "$1" && sqlite.settable "$1"
    sqlite.queryRO "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE'sqlite_%';"
}

# show rowcount of a table
#
# global  string  BSQLITE_TABLE  current table name
#
# param   string  optional: (can be skipped) table name
function sqlite.rowcount(){
    sqlite._wd "${FUNCNAME[0]}($*)"
    test -n "$1" && sqlite.settable "$1"

    sqlite.queryRO "select count(*) from '$BSQLITE_TABLE';"
}

# show rowcount of a table
#
# global  string  BSQLITE_TABLE  current table name
#
# param   string  optional: (can be skipped) table name
# param   string  code to execute after the query: WHERE, ORDER, LIMIT etc.
function sqlite.rows(){
    local _behind=
    sqlite._wd "${FUNCNAME[0]}($*)"
    if [ -n "$1" ]; then
        sqlite.settable "$1"
        shift
    fi
    _behind="$1"

    BSQLITE_MODE='table'
    sqlite.queryRO "select * from '$BSQLITE_TABLE' $_behind;"
    BSQLITE_MODE=''
}


# Check if table exists; check its exitcode or use an if then
# param  string  table name
function sqlite.tableexists(){
    local _table="$1"
    sqlite._wd "${FUNCNAME[0]}($_table)"

    if [ -z "$_table" ]; then
        echo "ERROR: ${FUNCNAME[0]}() No table name given"
        return 0
    fi
    sqlite.queryRO "SELECT name FROM sqlite_master WHERE type='table' AND name='${1}';" | grep -Fq "$1"
}

# ----------------------------------------------------------------------
# SETTERS
# ----------------------------------------------------------------------

# set sqlite file for current session
# param  string  sqlite file
function sqlite.setfile(){
    local sqlite_file="$1"
    sqlite._wd "${FUNCNAME[0]}($*)"
    BSQLITE_FILE="$sqlite_file"
    BSQLITE_TABLE=
    test ! -f "$sqlite_file" && sqlite._wd "${FUNCNAME[0]} HINT: File does not exist (yet)."
}

# set tablename for current session. The table must exist to set it.
# param  string  table name
function sqlite.settable(){
    sqlite._wd "${FUNCNAME[0]}($*)"
    if sqlite.tableexists "$1"; then
        BSQLITE_TABLE="$1"
    else
        echo "${FUNCNAME[0]} ERROR: the table [$1] does not exist. Default table still is [$BSQLITE_TABLE]"
    fi
}

# ----------------------------------------------------------------------
# CRUD actions
# ----------------------------------------------------------------------

# get bash code to create a hash with keys of a given table
#
# USAGE:
#   eval $( sqlite.newvar "users" "oUser")
#   ... creates variable "oUser"
#
# global  string  BSQLITE_TABLE      current table name
# global  string  BSQLITE_TABLENAME  constant for the key with the table name
#
# param   string  optional: (can be skipped) table name
# param   string  optional: variable name (default: table name)
function sqlite.newvar(){
    sqlite._wd "${FUNCNAME[0]}($*)"
    if [ -n "$2" ]; then
        sqlite.settable "$1"
        shift
    fi
    local _varname="${1:-$BSQLITE_TABLE}"
    local _script="unset ${_varname}; declare -A ${_varname}; ${_varname}[${BSQLITE_TABLENAME}]=${BSQLITE_TABLE}; "

    for col in $( sqlite.columns "$BSQLITE_TABLE" ); do
        _script+="${_varname}[${col}]=; "
    done
    echo "$_script"
}

# Store a given variable of a hash in the database.
# The save function detects the given id to switch between the
# create or update mode.
#
# param  string  vaiable name of a hash
function sqlite.save(){
    local _varname=$1
    local -n _hash=$1
    sqlite._wd "${FUNCNAME[0]}($*)"

    if [ -z "${_hash[id]}" ]; then
        sqlite._wd "${FUNCNAME[0]}() No id given -> create new record"
        sqlite.create "$_varname"
    else
        sqlite._wd "${FUNCNAME[0]}() id was found -> update record"
        sqlite.update "$_varname"
    fi
    return 0
}

# Create a database record.
# see also sqlite.save and sqlite.update
#
# global  string  BSQLITE_ID         constant for the key with the id
# global  string  BSQLITE_TABLE      current table name
# global  string  BSQLITE_TABLENAME  constant for the key with the table name
#
# param   string  variable name of a hash with row data to insert
function sqlite.create(){
    local -n _hash=$1
    local _sql
    sqlite._wd "${FUNCNAME[0]}($*)"

    if [ -z "${_hash[${BSQLITE_TABLENAME}]}" ]; then
        echo "ERROR: ${FUNCNAME[0]}() No table name given"
        return 1
    fi
    sqlite.settable "${_hash[${BSQLITE_TABLENAME}]}"

    local _collist; _collist="$( sqlite.columnlist "${_table}" | sed 's#^'${BSQLITE_ID}',##' | sed 's#,'${BSQLITE_ID}',#,#')"
    
    sqlite._wd "${FUNCNAME[0]}($*) - into table $_table"

    # $( sqlite.columns "${_hash[__table__]}" | tr '\n' ',' ) VALUES ('
    for _key in "${!_hash[@]}"; do
        test "$_key" == "${BSQLITE_TABLENAME}" && continue
        test "$_key" == "${BSQLITE_ID}" && continue

        test -n "$_sql" && _sql+=', '
        _sql+="'${_hash[$_key]}'"
    done

    _sql="INSERT INTO '${BSQLITE_TABLE}' ($_collist) VALUES ( $_sql );"

    sqlite.query "$_sql"
}

# Get an id of a database record. It returns bash code
# EXAMPLE
#   id="$( sqlite.getid users "username='axel'" )"
#
# global  string  BSQLITE_TABLE      current table name
#
# param   string  table to search
# param   string  WHERE statement to add to the select statement
function sqlite.getid(){
    local _table
    local _where
    local _sql
    sqlite._wd "${FUNCNAME[0]}($*)"

    _table="${1:-${BSQLITE_TABLE}}"
    _where="${2:-}"

    sqlite._wd "${FUNCNAME[0]}($*) - from table $_table"
    _sql="select id from users where $_where ORDER by id LIMIT 0,1"
    sqlite.queryRO "$_sql"
}

# get bash code to create a hash with keys of a given table
#
# USAGE:
# <code>
#   eval $( sqlite.read users 1 "oUser" )
#   ... creates variable "oUser" with users data of id=1
# </code>
#
# global  string  BSQLITE_TABLE      current table name
#
# param  string  optional: (can be skipped) table name
# param  string  value of id column
# param  string  optional: variable name (default: table name)
function sqlite.read(){
    local _table
    local _id
    sqlite._wd "${FUNCNAME[0]}($*)"
    if [ -n "$2" ]; then
        sqlite.settable "$1"
        shift;
    fi
    _id="${1:-0}"
    local _varname="${2:-$BSQLITE_TABLE}"
    if [ -n "$_id" ]; then
        local _result
        BSQLITE_MODE='json'
        _result="$( sqlite.queryRO "SELECT * from $BSQLITE_TABLE where id=$_id" )"
        BSQLITE_MODE=''

        # check if there is a json response starting with "[{"
        echo "unset ${_varname}"
        if grep -q "^\[{" <<< "$_result"; then
            echo "declare -A ${_varname}; ${_varname}[\"${BSQLITE_TABLENAME}\"]=\"${BSQLITE_TABLE}\"; "
            echo "$_result" | sed -e  's#^\[{##' -e 's#}]$##' -e 's#,"#\n"#g' -e 's#":#"]=#g' | sed 's#^#oUser\[#g'
        fi
    fi
}

# Update a record in a table
# see also sqlite.save and sqlite.create
#
# global  string  BSQLITE_TABLE      current table name
# global  string  BSQLITE_TABLENAME  constant for the key with the table name
#
# param   string  variable name of a hash with row data to update
function sqlite.update(){
    local -n _hash=$1
    local _sql
    sqlite._wd "${FUNCNAME[0]}($*)"

    if [ -z "${_hash[${BSQLITE_TABLENAME}]}" ]; then
        echo "ERROR: ${FUNCNAME[0]}() No table name given"
        return 1
    fi
    sqlite.settable "${_hash[${BSQLITE_TABLENAME}]}"

    if [ -n "${_hash[${BSQLITE_ID}]}" ]; then
        sqlite._wd "${FUNCNAME[0]}() - into table $BSQLITE_TABLE"
        
        for _key in "${!_hash[@]}"; do
            test "$_key" == "${BSQLITE_TABLENAME}" && continue

            test -n "$_sql" && _sql+=', '
            _sql+="$_key = '${_hash[$_key]}'"
        done

        _sql="UPDATE '${BSQLITE_TABLE}'
            SET $_sql
            WHERE ${BSQLITE_ID} = '${_hash[${BSQLITE_ID}]}';
            "

        sqlite.query "$_sql"
    else
        sqlite._wd "${FUNCNAME[0]}() - SKIP: no id given"
        return 1
    fi
}

# Delete a record in a table by a given hash that must contain a field "id"
#
# global  string  BSQLITE_ID         constant for the key with the id
# global  string  BSQLITE_TABLE      current table name
# global  string  BSQLITE_TABLENAME  constant for the key with the table name
#
# param   string  variable name of a hash with row data to fetch the field "id"
function sqlite.delete(){
    local -n _hash=$1
    local _id

    sqlite._wd "${FUNCNAME[0]}($*) - delete by given hash"
    if [ -z "${_hash[${BSQLITE_TABLENAME}]}" ]; then
        echo "ERROR: ${FUNCNAME[0]}() No table name given"
        return 1
    fi
    sqlite.settable "${_hash[${BSQLITE_TABLENAME}]}"

    # read the hash
    _id=${_hash[${BSQLITE_ID}]}
    if [ -n "${_hash[${BSQLITE_ID}]}" ]; then
        sqlite.deleteById "${BSQLITE_TABLE}" "$_id"
    else
        sqlite._wd "${FUNCNAME[0]}() - SKIP: no id given"
        return 1
    fi
}

# delete a single record in a table by a given id
#
# global  string  BSQLITE_ID         constant for the key with the id
# global  string  BSQLITE_TABLE      current table name
#
# param   string   optional: (can be skipped) table name
# param   integer  id to delete
function sqlite.deleteById(){
    sqlite._wd "${FUNCNAME[0]}($*)"
    if [ -n "$2" ]; then
        sqlite.settable "$1"
        shift;
    fi
    local _id; _id="$1"

    sqlite._wd "${FUNCNAME[0]}($*) - delete id $_id of table $BSQLITE_TABLE"

    if [ -n "$_id" ] || [ -n "$BSQLITE_TABLE" ] || sqlite.tableexists "$BSQLITE_TABLE"; then
        _sql="DELETE FROM '$BSQLITE_TABLE' 
            WHERE ${BSQLITE_ID} = $_id;
            "
        sqlite.query "$_sql"
    else
        sqlite._wd "${FUNCNAME[0]}() - SKIP: missing id or (wrong?) table"
        return 1
    fi
}

# ----------------------------------------------------------------------

# check requirements
which sqlite3 >/dev/null 2>&1 || { echo >&2 "ERROR: sqlite3 is required for $BSQLITE_SELF but it's not installed. Aborting."; exit 1; }


# ----------------------------------------------------------------------
