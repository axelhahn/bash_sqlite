## sqlite.class.sh

### sqlite.columnlist()

```txt
show columns of a table each in a single line
param  string  optional: sqlite file
param  string  optional: table name
```

[line: 160](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L160)

### sqlite.columns()

```txt
show columns of a table seperated with comma
param  string  optional: sqlite file
param  string  optional: table name
```

[line: 181](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L181)

### sqlite.create()

```txt
Create a database record.
see also sqlite.save and sqlite.update

param  string  variable name of a hash with row data to insert
```

[line: 276](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L276)

### sqlite.debugOff()

```txt
disable debugging
```

[line: 41](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L41)

### sqlite.debugOn()

```txt
enable debugging
```

[line: 45](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L45)

### sqlite.delete()

```txt
Delete a record in a table by a given hash that must contain a field "id"
param  string  variable name of a hash with row data to fetch the field "id"
```

[line: 389](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L389)

### sqlite.deleteById()

```txt
delete a single record in a table by a given id
param  integer  id to delete
param  string   optional: table name
```

[line: 409](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L409)

### sqlite.getid()

```txt
INCOMPLETE
Get an id of a database record. It returns bash code
EXAMPLE
  id="$( sqlite.getid users "username='axel'" )"

param  string  table to search
param  string  WHERE statement to add to the select statement
```

[line: 306](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L306)

### sqlite.ini()

```txt
read the given ini file and create the tables if file does not exist yet
It calls sqlite.setfile <FILE> to set a default sqlite file

param  string  filename of ini file
```

[line: 104](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L104)

### sqlite.init()

```txt
Set the sqlite file and current table name
You can set its parameters individually too:
  sqlite.setfile "$1"
  sqlite.settable "$2"

param  string  filename
param  string  table name
```

[line: 147](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L147)

### sqlite.newvar()

```txt
get bash code to create a hash with keys of a given table

USAGE:
  eval $( sqlite.newvar "users" "oUser")
  ... creates variable "oUser"

param  string  table name
param  string  optional: variable name (default: table name)
```

[line: 242](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L242)

### sqlite.query()

```txt
execute a given sql query
see also: sqlite.queryRO

param  string  optional: file
param  string  query
```

[line: 59](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L59)

### sqlite.queryRO()

```txt
Readonly query: it sets a readonly flag for the sqlite binary to execute the
given query with readonly access
see also: sqlite.query

param  string  optional: file
param  string  query
```

[line: 90](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L90)

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

[line: 327](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L327)

### sqlite.save()

```txt
Store a given variable of a hash in the database.
The save function detects the given id to switch between the
create or update mode.

param  string  vaiable name of a hash
```

[line: 258](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L258)

### sqlite.setfile()

```txt
set sqlite file for current session
param  string  sqlite file
```

[line: 213](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L213)

### sqlite.settable()

```txt
set tablename for current session
param  string  table name
```

[line: 222](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L222)

### sqlite.tableexists()

```txt
Check if table exists; check its exitcode or use an if then
param  string  table name
```

[line: 196](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L196)

### sqlite.tables()

```txt
show tables of current sqlite file each in a single line
param  string  optional: sqlite file
```

[line: 187](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L187)

### sqlite.update()

```txt
Update a record in a table
see also sqlite.save and sqlite.create

param  string  variable name of a hash with row data to update
```

[line: 359](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L359)

