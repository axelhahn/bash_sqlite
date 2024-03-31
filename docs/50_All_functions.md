## sqlite.class.sh

### sqlite.columnlist()

```txt
show columns of a table each in a single line
param  string  can be skipped: sqlite file
param  string  can be skipped: table name
```

[line: 167](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L167)

### sqlite.columns()

```txt
show columns of a table seperated with comma
param  string  can be skipped: sqlite file
param  string  can be skipped: table name
```

[line: 188](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L188)

### sqlite.create()

```txt
Create a database record.
see also sqlite.save and sqlite.update

param  string  variable name of a hash with row data to insert
```

[line: 316](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L316)

### sqlite.debugOff()

```txt
disable debugging
```

[line: 43](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L43)

### sqlite.debugOn()

```txt
enable debugging
```

[line: 48](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L48)

### sqlite.delete()

```txt
Delete a record in a table by a given hash that must contain a field "id"
param  string  variable name of a hash with row data to fetch the field "id"
```

[line: 439](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L439)

### sqlite.deleteById()

```txt
delete a single record in a table by a given id
param  string   can be skipped: table name
param  integer  id to delete
```

[line: 463](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L463)

### sqlite.getid()

```txt
INCOMPLETE
Get an id of a database record. It returns bash code
EXAMPLE
  id="$( sqlite.getid users "username='axel'" )"

param  string  table to search
param  string  WHERE statement to add to the select statement
```

[line: 352](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L352)

### sqlite.ini()

```txt
read the given ini file and create the tables if file does not exist yet
It calls sqlite.setfile <FILE> to set a default sqlite file

param  string  filename of ini file
```

[line: 108](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L108)

### sqlite.init()

```txt
Set the sqlite file and current table name
You can set its parameters individually too:
  sqlite.setfile "$1"
  sqlite.settable "$2"

param  string  filename
param  string  table name
```

[line: 153](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L153)

### sqlite.newvar()

```txt
get bash code to create a hash with keys of a given table

USAGE:
  eval $( sqlite.newvar "users" "oUser")
  ... creates variable "oUser"

param  string  can be skipped: table name
param  string  optional: variable name (default: table name)
```

[line: 277](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L277)

### sqlite.query()

```txt
execute a given sql query
see also: sqlite.queryRO

param  string  can be skipped: file
param  string  query
```

[line: 63](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L63)

### sqlite.queryRO()

```txt
Readonly query: it sets a readonly flag for the sqlite binary to execute the
given query with readonly access
see also: sqlite.query

param  string  can be skipped: file
param  string  query
```

[line: 94](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L94)

### sqlite.read()

```txt
get bash code to create a hash with keys of a given table

USAGE:
  eval $( sqlite.read users 1 "oUser" )
  ... creates variable "oUser" with users data of id=1

param  string  can be skipped: table name
param  string  value of id column
param  string  optional: variable name (default: table name)
```

[line: 375](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L375)

### sqlite.rowcount()

```txt
show rowcount of a table
param  string  can be skipped: table name
```

[line: 202](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L202)

### sqlite.rows()

```txt
show rowcount of a table
param  string  can be skipped: table name
param  string  code to execute after the query: WHERE, ORDER, LIMIT etc.
```

[line: 212](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L212)

### sqlite.save()

```txt
Store a given variable of a hash in the database.
The save function detects the given id to switch between the
create or update mode.

param  string  vaiable name of a hash
```

[line: 297](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L297)

### sqlite.setfile()

```txt
set sqlite file for current session
param  string  sqlite file
```

[line: 246](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L246)

### sqlite.settable()

```txt
set tablename for current session
param  string  table name
```

[line: 256](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L256)

### sqlite.tableexists()

```txt
Check if table exists; check its exitcode or use an if then
param  string  table name
```

[line: 229](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L229)

### sqlite.tables()

```txt
show tables of current sqlite file each in a single line
param  string  optional: sqlite file
```

[line: 194](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L194)

### sqlite.update()

```txt
Update a record in a table
see also sqlite.save and sqlite.create

param  string  variable name of a hash with row data to update
```

[line: 404](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L404)

