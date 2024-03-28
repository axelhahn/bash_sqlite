## Source the files

Next to all functions of the `sqlite3` command, the `sqlite3.class.sh` file provides several functions.

The basic syntax is **sqlite** + dot + *function*.

To use them you need to source the file sqlite.class.sh:

```bash
cd $( dirname $0 )
. vendor/sqlite.class.sh || exit 1
```


## Abstract initialisation

If you don't want to repeat the database file as argument each time, you can use 

`sqlite.setfile "<SQLITE-FILE>"`

This function does not stop if the file does not exist yet.

`sqlite.settable "<TABLE>"`

This function sets the table to be used. This can be helpful when using the CRUD functions.

`sqlite.init "<SQLITE-FILE>" "<TABLE>"`

This is the combination in a single function.

### Create tables - raw SQL

Before we can insert data, we need to create a table.

🔷 **Syntax**:

`sqlite.query "<QUERY>"`

You can use `sqlite.query "<QUERY>"` to execute any query. Here we need the CREATE TABLE statement.

See https://www.sqlite.org/lang_createtable.html

✏️ **Example**:

```bash
sqlite.query "CREATE TABLE users (
    id integer primary key autoincrement,
    username text
    lastname text
    firstname text
    groups text
);"
```

**Important**:

Define `id integer primary key autoincrement` in all your tables. to work with the sqlite.class.sh functions.

### Create tables - use an INI file

To shorten the initialisation and table creation process, there is a function to use an INI file to set the database file and define the table structure to be created. For ini parsing functions you additionally need the ini.class.sh which is provided in the `./vendor/` subdir.

🔷 **Syntax**:

`sqlite.ini "<INI-FILE>"`

The ini file contains

* section **[sqlite]**
  * `file = <SQLITE-FILE>` for a filename
* multiple sections **[table.TABLENAME]**
  * once `id = integer primary key autoincrement` for the primary key
  * multiple `<name> = <type>` for the column name and type allowed by sqlite

✏️ **Example** of an ini file:

```ini
[sqlite]
file = "example.db"

[table.users]
id = integer primary key autoincrement
username = text
lastname = text
firstname = text
groups = text

[table.groups]
id = integer primary key
groupname = text
```

Bash snippet to use the ini file:

```bash
. vendor/sqlite.class.sh || exit 1
. vendor/ini.class.sh    || exit 1

sqlite.ini "example.ini"
```

sqlite.ini simplifies a few things for you:

* it sets the default sqlite file based on [sqlite] -> file
* it parses the table definitions and detects every missing table to create it. BUT it does nothing if the table exists and has another definition.


## Information

### Show tables

🔷 **Syntax**:

`sqlite.tables ["<DB-FILE>"]`

.. shows ech existing table seperated with a new line.

The optional 1st parameter overrides the file of a former `sqlite.setfile <DB-FILE>`

This function uses the readonly mode of sqlite.

✏️ **Example** return:

```txt
users
groups
```

### Table exists

🔷 **Syntax**:

`sqlite.tableexists "<tablename>"`

This function requires a set database file.

✏️ **Example**:

```bash
if ! sqlite.tableexists "$tablename"; then
    echo "ERROR: table '$tablename' does not exist"
    exit 1
fi
echo "OK: table '$tablename' was found"
```

### Show colums

🔷 **Syntax**:

`sqlite.columns ["<DB-FILE>"] "<tablename>"`

The optional 1st parameter overrides the file of a former `sqlite.setfile <DB-FILE>`

This function uses the readonly mode of sqlite.

✏️ **Example**:

```bash
echo "--- colums if table 'users'"
sqlite.columns "users"
```

returns

```txt
--- columns of table 'users'
id
groups
username
lastname
firstname
```

### Show colums as list

You can get a comma seperated list of all columns of a table.
You get the same result like from sqlite.columns but in a single line.

🔷 **Syntax**:

`sqlite.columnlist ["<DB-FILE>"] "<tablename>"`

✏️ **Example**:

```bash
echo "--- column list of table 'users'"
sqlite.columnlist "users"
```

returns something like
  
```txt
--- column list of table 'users'
id,groups,username,lastname,firstname
```

## CRUD

### Create a new row

You can get a hash with each key as column name and value as column value.

🔷 **Syntax**:

`eval "$( sqlite.newvar '<TABLE>' '<VARIABLE>' )"`

✏️ **Example**:

`eval "$( sqlite.newvar 'users' 'oUser' )"`

It creates a variable with the name `oUser` and sets it to the hash.

```txt
oUser = [
  id => 
  groups => 
  username => 
  lastname => 
  __table__ => users
  firstname => 
]
```

Please notice: 

* all values including  `id` as primary key are ampty
* there is a special key `__table__` which contains the table name. 

Now modify the keys of the hash as needed.

```bash
oUser['username']='axel'
oUser['firstname']='Axel'
oUser['lastname']='Hahn'
```

To store your data in the database use

`sqlite.save "oUser"`
or
`sqlite.save "oUser"`

Please notice: 

* The argument is a string - the variable name of your hash
* There is no database file -you need sqlite.setfile before
* There is no table name - it will be taken from the internally set key `__table__`
* the sqlite.save function detects a value in field `id` to create a new row or save (update) data of an existing row.<br>Remark: `sqlite.create "oUser"` will ignore any given id and save a new row.

### Read

To get a hash of a database row we can use the `id` column. To Create a hash with the values of a row we can use the eval function.

🔷 **Syntax**:

`eval "$( sqlite.read <tablename> <id> <variable> )"`

✏️ **Example**:

```bash
eval "$( sqlite.read users 1 oUser )"
```

You get a variable `oUser` with the values of the database row with the id 1.

```txt
oUser = [
  id => 1
  groups => 
  username => axel
  lastname => Hahn
  __table__ => users
  firstname => Axel
]
```

Please notice: 

* `id` is now a set value - do not change it
* `__table__` is the table name for the update - do not change it

### Update

🔷 **Syntax**:

`sqlite.update "<variable>"`

To update a row we need the variablename of the hash and use 

* the `id` column to identify the row
* the `__table__` key to identify the table

✏️ **Example**:

`sqlite.update "oUser"`

Remark: `sqlite.save "oUser"` will do the same.

### Delete

Similiar to the create and update there is a delete function - it uses id of the hash to delete a row. 

🔷 **Syntax**:

`sqlite.delete "<variable>"`

* the `id` column to identify the row
* the `__table__` key to identify the table

✏️ **Example**:

`sqlite.delete "oUser"`

### Delete with given id

An alternative function to delete a row is to give id and tablename as parameters.

🔷 **Syntax**:

`sqlite.deleteById <ID> "<tablename>"`

✏️ **Example**:

`sqlite.deleteById 2 "users"`
