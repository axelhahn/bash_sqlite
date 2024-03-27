## Source the files

```bash
cd $( dirname $0 )
. vendor/sqlite.class.sh || exit 1
. vendor/ini.class.sh || exit 1
```

## Use its functions

Next to all functions of the `sqlite3` command, the `sqlite3.class.sh` file provides the following functions.

The basic syntax is `sqlite` + dot + `function` + `parameters`

### Abstract initialisation

If you don't want to repeat the database file as argument each time, you can use 

#### `sqlite.setfile "<SQLITE-FILE>"`

This function does not stop if the file does not exist yet.

#### `sqlite.settable "<TABLE>"`

This function sets the table to be used. This can be helpful when using the CRUD functions.

#### `sqlite.init "<SQLITE-FILE>" "<TABLE>"`

This is the combination in a single function.

#### Use an INI file

There is a function to use an INI file to set the database file and define the table structure to be created.

`sqlite.ini "<INI-FILE>"`

It will create every missing table by given configuration. BUT it does nothing if the table exists and has another definition.

The ini file contains

* section **[sqlite]**
  * `file = <filename>` for a filename to create if needed,
* multiple sections **[table.TABLENAME]**
  * once `id = integer primary key autoincrement` for the primary key
  * multiple `<name> = <type>` for the column name and type allowed by sqlite

Example of an ini file:

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

### Information

#### Show tables

Syntax:

`sqlite.tables ["<DB-FILE>"]`

.. shows ech existing table seperated with a new line.

The optional 1st parameter overrides the file of a former `sqlite.setfile <DB-FILE>`

This function uses the readonly mode of sqlite.

Example return:

```txt
users
groups
```
#### Table exists

`sqlite.tableexists "<tablename>"`

This function requires a set database file.

Example:

```shell
if ! sqlite.tableexists "$tablename"; then
    echo "ERROR: table '$tablename' does not exist"
    exit 1
fi
echo "OK: table '$tablename' was found"
```

#### Show colums

Syntax:

`sqlite.tables ["<DB-FILE>"] "<tablename>"`

The optional 1st parameter overrides the file of a former `sqlite.setfile <DB-FILE>`

This function uses the readonly mode of sqlite.

Example:

```shell
echo "--- colums if table 'users'"
sqlite.columns "users"
```

returns

```txt
--- colums if table 'users'
id
groups
username
lastname
firstname
```

### CRUD

#### New row

You can get a hash with each key as column name and value as column value.

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

To store your data in the database use

`sqlite.save "oUser"`

Please notice: 

* The argument is a string - the variable name of your hash
* There is no database file -you need sqlite.setfile before
* There is no table name - it will be taken from the internally set key `__table__`
* the sqlite.save function detects a value in fiel `id` to create a new row or save (update) data of an existing row.<br>Remark: `sqlite.create "oUser"` will ignore any given id and save a new row.

#### Read

To get a hash of a database row we can use the `id` column. To Create a hash with the values of a row we can use the eval function.

`eval "$( sqlite.read <tablename> <id> <variable> )"`

Example:

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

#### Update


`sqlite.update <tablename> <id> <variable>`

