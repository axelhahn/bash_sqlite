## sqlite.class.sh

List of all functions in alphabetic order

### sqlite.columnlist()

```txt
Show columns of a table each in a single line

🌐 global  string  $BSQLITE_FILE   file to execute the query on
🌐 global  string  $BSQLITE_TABLE  current table name

🔹 param   string  optional: (can be skipped) sqlite file
🔹 param   string  optional: (can be skipped) table name
```

[line: 179](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L179)

### sqlite.columns()

```txt
Show columns of a table seperated with comma

🌐 global  string  $BSQLITE_FILE   file to execute the query on
🌐 global  string  $BSQLITE_TABLE  current table name

🔹 param   string  optional: (can be skipped) sqlite file
🔹 param   string  optional: (can be skipped) table name
```

[line: 204](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L204)

### sqlite.create()

```txt
Create a database record.
👉🏼 see also sqlite.save and sqlite.update

🌐 global  string  $BSQLITE_ID         constant for the key with the id
🌐 global  string  $BSQLITE_TABLE      current table name
🌐 global  string  $BSQLITE_TABLENAME  constant for the key with the table name

🟩 param   string  variable name of a hash with row data to insert
```

[line: 348](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L348)

### sqlite.debugOff()

```txt
Disable debugging: turn off additional output
👉🏼 see also: sqlite.debugOn()
```

[line: 45](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L45)

### sqlite.debugOn()

```txt
Enable debugging: show more output on STDERR
👉🏼 see also: sqlite.debugOff()
```

[line: 51](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L51)

### sqlite.delete()

```txt
Delete a record in a table by a given hash that must contain a field "id"

🌐 global  string  $BSQLITE_ID         constant for the key with the id
🌐 global  string  $BSQLITE_TABLE      current table name
🌐 global  string  $BSQLITE_TABLENAME  constant for the key with the table name

🟩 param   string  variable name of a hash with row data to fetch the field "id"
```

[line: 484](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L484)

### sqlite.deleteById()

```txt
Delete a single record in a table by a given id

🌐 global  string  $BSQLITE_ID         constant for the key with the id
🌐 global  string  $BSQLITE_TABLE      current table name

🔹 param   string   optional: (can be skipped) table name
🟩 param   integer  id to delete
```

[line: 512](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L512)

### sqlite.getid()

```txt
Get an id of a database record. It returns bash code
EXAMPLE
  id="$( sqlite.getid users "username='axel'" )"

🌐 global  string  $BSQLITE_TABLE      current table name

🟩 param   string  table to search
🟩 param   string  WHERE statement to add to the select statement
```

[line: 385](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L385)

### sqlite.ini()

```txt
Read the given ini file and create the tables if file does not exist yet
It calls sqlite.setfile <FILE> to set a default sqlite file

🟩 param  string  filename of ini file
```

[line: 115](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L115)

### sqlite.init()

```txt
Set the sqlite file and current table name
You can set its parameters individually too:
👉🏼 see also: sqlite.setfile
👉🏼 see also: sqlite.settable

🟩 param  string  filename
🟩 param  string  table name
```

[line: 161](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L161)

### sqlite.newvar()

```txt
Get bash code to create a hash with keys of a given table

USAGE:
  eval $( sqlite.newvar "users" "oUser")
  ... creates variable "oUser"

🌐 global  string  $BSQLITE_TABLE      current table name
🌐 global  string  $BSQLITE_TABLENAME  constant for the key with the table name

🔹 param   string  optional: (can be skipped) table name
🔹 param   string  optional: variable name (default: table name)
```

[line: 305](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L305)

### sqlite.query()

```txt
Execute a given sql query on the given file
👉🏼 see also: sqlite.queryRO()

🌐 global  string  $BSQLITE_FILE  file to execute the query on

🔹 param   string  optional: (can be skipped) file
🟩 param   string  query
```

[line: 68](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L68)

### sqlite.queryRO()

```txt
Readonly query: it sets a readonly flag for the sqlite binary to execute the
given query with readonly access
👉🏼 see also: sqlite.query()

🌐 global  string  $BSQLITE_FILE  file to execute the query on

🔹 param   string  optional: (can be skipped) file
🟩 param   string  query
```

[line: 101](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L101)

### sqlite.read()

```txt
Get bash code to create a hash with keys of a given table.

USAGE:
<code>
  eval $( sqlite.read users 1 "oUser" )
  ... creates variable "oUser" with users data of id=1
</code>

🌐 global  string  $BSQLITE_TABLE      current table name

🔹 param   string  optional: (can be skipped) table name
🟩 param   string  value of id column
🔹 param   string  optional: variable name (default: table name)
```

[line: 412](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L412)

### sqlite.rowcount()

```txt
Show rowcount of a table

🌐 global  string  $BSQLITE_TABLE  current table name

🔹 param   string  optional: (can be skipped) table name
```

[line: 224](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L224)

### sqlite.rows()

```txt
Show rowcount of a table

🌐 global  string  $BSQLITE_TABLE  current table name

🔹 param   string  optional: (can be skipped) table name
🟩 param   string  code to execute after the query: WHERE, ORDER, LIMIT etc.
```

[line: 237](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L237)

### sqlite.save()

```txt
Store a given variable of a hash in the database.
The save function detects the given id to switch between the
create or update mode.

🟩 param  string  vaiable name of a hash
```

[line: 325](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L325)

### sqlite.setfile()

```txt
Set sqlite file for current session
🟩 param  string  sqlite file
```

[line: 271](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L271)

### sqlite.settable()

```txt
set tablename for current session. The table must exist to set it.
🟩 param  string  table name
```

[line: 281](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L281)

### sqlite.tableexists()

```txt
Check if table exists; check its exitcode or use an if then
🟩 param  string  table name
```

[line: 254](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L254)

### sqlite.tables()

```txt
Show tables of current sqlite file each in a single line

🌐 global  string  $BSQLITE_TABLE  current table name

🔹 param   string  optional: sqlite file
```

[line: 213](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L213)

### sqlite.update()

```txt
Update a record in a table
👉🏼 see also sqlite.save and sqlite.create

🌐 global  string  $BSQLITE_TABLE      current table name
🌐 global  string  $BSQLITE_TABLENAME  constant for the key with the table name

🟩 param   string  variable name of a hash with row data to update
```

[line: 444](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L444)

- - -
Generated with [Bashdoc](https://github.com/axelhahn/bashdoc) v0.7
