## sqlite.class.sh

List of all functions in alphabetic order

### sqlite.columnlist()

<html><pre><code class="language-txt bashdoc">show columns of a table each in a single line
<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">can be skipped: sqlite file</span>
<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">can be skipped: table name</span>
</code></pre></html>

[line: 167](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L167)

### sqlite.columns()

<html><pre><code class="language-txt bashdoc">show columns of a table seperated with comma
<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">can be skipped: sqlite file</span>
<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">can be skipped: table name</span>
</code></pre></html>

[line: 188](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L188)

### sqlite.create()

<html><pre><code class="language-txt bashdoc">Create a database record.
see also sqlite.save and sqlite.update

<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">variable name of a hash with row data to insert</span>
</code></pre></html>

[line: 316](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L316)

### sqlite.debugOff()

<html><pre><code class="language-txt bashdoc">disable debugging
</code></pre></html>

[line: 43](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L43)

### sqlite.debugOn()

<html><pre><code class="language-txt bashdoc">enable debugging
</code></pre></html>

[line: 48](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L48)

### sqlite.delete()

<html><pre><code class="language-txt bashdoc">Delete a record in a table by a given hash that must contain a field "id"
<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">variable name of a hash with row data to fetch the field "id"</span>
</code></pre></html>

[line: 440](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L440)

### sqlite.deleteById()

<html><pre><code class="language-txt bashdoc">delete a single record in a table by a given id
<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">can be skipped: table name</span>
<span class="prefix">param</span> <span class="type type-integer">integer</span> <span class="descr">id to delete</span>
</code></pre></html>

[line: 464](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L464)

### sqlite.getid()

<html><pre><code class="language-txt bashdoc">Get an id of a database record. It returns bash code
EXAMPLE
id="$( sqlite.getid users "username='axel'" )"

<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">table to search</span>
<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">WHERE statement to add to the select statement</span>
</code></pre></html>

[line: 351](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L351)

### sqlite.ini()

<html><pre><code class="language-txt bashdoc">read the given ini file and create the tables if file does not exist yet
It calls sqlite.setfile <FILE> to set a default sqlite file

<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">filename of ini file</span>
</code></pre></html>

[line: 108](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L108)

### sqlite.init()

<html><pre><code class="language-txt bashdoc">Set the sqlite file and current table name
You can set its parameters individually too:
sqlite.setfile "$1"
sqlite.settable "$2"

<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">filename</span>
<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">table name</span>
</code></pre></html>

[line: 153](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L153)

### sqlite.newvar()

<html><pre><code class="language-txt bashdoc">get bash code to create a hash with keys of a given table

USAGE:
eval $( sqlite.newvar "users" "oUser")
... creates variable "oUser"

<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">can be skipped: table name</span>
<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">optional: variable name (default: table name)</span>
</code></pre></html>

[line: 277](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L277)

### sqlite.query()

<html><pre><code class="language-txt bashdoc">execute a given sql query
see also: sqlite.queryRO

<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">can be skipped: file</span>
<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">query</span>
</code></pre></html>

[line: 63](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L63)

### sqlite.queryRO()

<html><pre><code class="language-txt bashdoc">Readonly query: it sets a readonly flag for the sqlite binary to execute the
given query with readonly access
see also: sqlite.query

<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">can be skipped: file</span>
<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">query</span>
</code></pre></html>

[line: 94](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L94)

### sqlite.read()

<html><pre><code class="language-txt bashdoc">get bash code to create a hash with keys of a given table

USAGE:
<code>
eval $( sqlite.read users 1 "oUser" )
... creates variable "oUser" with users data of id=1
</code>

<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">can be skipped: table name</span>
<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">value of id column</span>
<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">optional: variable name (default: table name)</span>
</code></pre></html>

[line: 376](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L376)

### sqlite.rowcount()

<html><pre><code class="language-txt bashdoc">show rowcount of a table
<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">can be skipped: table name</span>
</code></pre></html>

[line: 202](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L202)

### sqlite.rows()

<html><pre><code class="language-txt bashdoc">show rowcount of a table
<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">can be skipped: table name</span>
<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">code to execute after the query: WHERE, ORDER, LIMIT etc.</span>
</code></pre></html>

[line: 212](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L212)

### sqlite.save()

<html><pre><code class="language-txt bashdoc">Store a given variable of a hash in the database.
The save function detects the given id to switch between the
create or update mode.

<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">vaiable name of a hash</span>
</code></pre></html>

[line: 297](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L297)

### sqlite.setfile()

<html><pre><code class="language-txt bashdoc">set sqlite file for current session
<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">sqlite file</span>
</code></pre></html>

[line: 246](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L246)

### sqlite.settable()

<html><pre><code class="language-txt bashdoc">set tablename for current session
<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">table name</span>
</code></pre></html>

[line: 256](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L256)

### sqlite.tableexists()

<html><pre><code class="language-txt bashdoc">Check if table exists; check its exitcode or use an if then
<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">table name</span>
</code></pre></html>

[line: 229](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L229)

### sqlite.tables()

<html><pre><code class="language-txt bashdoc">show tables of current sqlite file each in a single line
<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">optional: sqlite file</span>
</code></pre></html>

[line: 194](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L194)

### sqlite.update()

<html><pre><code class="language-txt bashdoc">Update a record in a table
see also sqlite.save and sqlite.create

<span class="prefix">param</span> <span class="type type-string">string</span> <span class="descr">variable name of a hash with row data to update</span>
</code></pre></html>

[line: 405](https://github.com/axelhahn/bash_sqlite/blob/main/sqlite.class.sh#L405)

