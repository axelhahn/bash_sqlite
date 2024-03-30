## sqlite.class.sh

### sqlite.columnlist()

```txt
show columns of a table each in a single line
param  string  optional: sqlite file
param  string  optional: table name
```

[line: 161](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L161)

### sqlite.columns()

```txt
show columns of a table seperated with comma
param  string  optional: sqlite file
param  string  optional: table name
```

[line: 182](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L182)

### sqlite.create()

```txt
Create a database record.
see also sqlite.save and sqlite.update

param  string  variable name of a hash with row data to insert
```

[line: 277](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L277)

### sqlite.debugOff()

```txt
disable debugging
```

[line: 42](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L42)

### sqlite.debugOn()

```txt
enable debugging
```

[line: 46](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L46)

### sqlite.delete()

```txt
Delete a record in a table by a given hash that must contain a field "id"
param  string  variable name of a hash with row data to fetch the field "id"
```

[line: 391](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L391)

### sqlite.deleteById()

```txt
delete a single record in a table by a given id
param  integer  id to delete
param  string   optional: table name
```

[line: 411](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L411)

### sqlite.getid()

```txt
INCOMPLETE
Get an id of a database record. It returns bash code
EXAMPLE
  id="$( sqlite.getid users "username='axel'" )"

param  string  table to search
param  string  WHERE statement to add to the select statement
```

[line: 307](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L307)

### sqlite.ini()

```txt
read the given ini file and create the tables if file does not exist yet
It calls sqlite.setfile <FILE> to set a default sqlite file

param  string  filename of ini file
```

[line: 105](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L105)

### sqlite.init()

```txt
Set the sqlite file and current table name
You can set its parameters individually too:
  sqlite.setfile "$1"
  sqlite.settable "$2"

param  string  filename
param  string  table name
```

[line: 148](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L148)

### sqlite.newvar()

```txt
get bash code to create a hash with keys of a given table

USAGE:
  eval $( sqlite.newvar "users" "oUser")
  ... creates variable "oUser"

param  string  table name
param  string  optional: variable name (default: table name)
```

[line: 243](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L243)

### sqlite.query()

```txt
execute a given sql query
see also: sqlite.queryRO

param  string  optional: file
param  string  query
```

[line: 60](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L60)

### sqlite.queryRO()

```txt
Readonly query: it sets a readonly flag for the sqlite binary to execute the
given query with readonly access
see also: sqlite.query

param  string  optional: file
param  string  query
```

[line: 91](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L91)

### sqlite.read()

```txt
get bash code to create a hash with keys of a given table

USAGE:
  eval $( sqlite.read users 1 "oUser" )
  ... creates variable "oUser" with users data of id=1

param  string  table name
param  string  value of id column
param  string  optional: variable name (default: table name)
```

[line: 328](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L328)

### sqlite.save()

```txt
Store a given variable of a hash in the database.
The save function detects the given id to switch between the
create or update mode.

param  string  vaiable name of a hash
```

[line: 259](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L259)

### sqlite.setfile()

```txt
set sqlite file for current session
param  string  sqlite file
```

[line: 214](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L214)

### sqlite.settable()

```txt
set tablename for current session
param  string  table name
```

[line: 223](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L223)

### sqlite.tableexists()

```txt
Check if table exists; check its exitcode or use an if then
param  string  table name
```

[line: 197](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L197)

### sqlite.tables()

```txt
show tables of current sqlite file each in a single line
param  string  optional: sqlite file
```

[line: 188](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L188)

### sqlite.update()

```txt
Update a record in a table
see also sqlite.save and sqlite.create

param  string  variable name of a hash with row data to update
```

[line: 361](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L361)

