
## Legend

|     |
| --- |  
| Read |
| Write |
| General |
| Functions |
| Schema |
| Performance |
| Multidatabase |
| Security |

## Syntax

  
| Read query structure |
| --- |
| \[MATCH WHERE\]<br>\[OPTIONAL MATCH WHERE\]<br>\[WITH \[ORDER BY\] \[SKIP\] \[LIMIT\]\]<br>RETURN \[ORDER BY\] \[SKIP\] \[LIMIT\] |

  
| MATCH [](https://neo4j.com/docs/cypher-manual/4.2/clauses/match) |
| --- |
| MATCH (n:Person)\-\[:KNOWS\]\->(m:Person)<br>WHERE n.name = 'Alice'<br><br>Node patterns can contain labels and properties. |
| MATCH (n)\-->(m)<br><br>Any pattern can be used in `MATCH`. |
| MATCH (n {name: 'Alice'})\-->(m)<br><br>Patterns with node properties. |
| MATCH p = (n)\-->(m)<br><br>Assign a path to `p`. |
| OPTIONAL MATCH (n)\-\[r\]\->(m)<br><br>Optional pattern: `null`s will be used for missing parts. |

  
| WHERE [](https://neo4j.com/docs/cypher-manual/4.2/clauses/where) |
| --- |
| WHERE n.property <> $value<br><br>Use a predicate to filter. Note that `WHERE` is always part of a `MATCH`, `OPTIONAL MATCH` or `WITH` clause. Putting it after a different clause in a query will alter what it does. |
| WHERE EXISTS {<br>  MATCH (n)\-->(m) WHERE n.age = m.age<br>}<br><br>Use an existential subquery to filter. |

  
| Write-only query structure |
| --- |
| (CREATE \| MERGE)\*<br>\[SET\|DELETE\|REMOVE\|FOREACH\]\*<br>\[RETURN \[ORDER BY\] \[SKIP\] \[LIMIT\]\] |

  
| Read-write query structure |
| --- |
| \[MATCH WHERE\]<br>\[OPTIONAL MATCH WHERE\]<br>\[WITH \[ORDER BY\] \[SKIP\] \[LIMIT\]\]<br>(CREATE \| MERGE)\*<br>\[SET\|DELETE\|REMOVE\|FOREACH\]\*<br>\[RETURN \[ORDER BY\] \[SKIP\] \[LIMIT\]\] |

  
| CREATE [](https://neo4j.com/docs/cypher-manual/4.2/clauses/create) |
| --- |
| CREATE (n {name: $value})<br><br>Create a node with the given properties. |
| CREATE (n $map)<br><br>Create a node with the given properties. |
| UNWIND $listOfMaps AS properties<br>CREATE (n) SET n = properties<br><br>Create nodes with the given properties. |
| CREATE (n)\-\[r:KNOWS\]\->(m)<br><br>Create a relationship with the given type and direction; bind a variable to it. |
| CREATE (n)\-\[:LOVES {since: $value}\]\->(m)<br><br>Create a relationship with the given type, direction, and properties. |

  
| SET [](https://neo4j.com/docs/cypher-manual/4.2/clauses/set) |
| --- |
| SET n.property1 = $value1,<br>    n.property2 = $value2<br><br>Update or create a property. |
| SET n = $map<br><br>Set all properties. This will remove any existing properties. |
| SET n += $map<br><br>Add and update properties, while keeping existing ones. |
| SET n:Person<br><br>Adds a label `Person` to a node. |

  
| Import [](https://neo4j.com/docs/cypher-manual/4.2/clauses/load-csv) |
| --- |
| LOAD CSV FROM<br>'https://neo4j.com/docs/cypher-refcard/4.2/csv/artists.csv' AS line<br>CREATE (:Artist {name: line\[1\], year: toInteger(line\[2\])})<br><br>Load data from a CSV file and create nodes. |
| LOAD CSV WITH HEADERS FROM<br>'https://neo4j.com/docs/cypher-refcard/4.2/csv/artists-with-headers.csv' AS line<br>CREATE (:Artist {name: line.Name, year: toInteger(line.Year)})<br><br>Load CSV data which has headers. |
| USING PERIODIC COMMIT 500<br>LOAD CSV WITH HEADERS FROM<br>'https://neo4j.com/docs/cypher-refcard/4.2/csv/artists-with-headers.csv' AS line<br>CREATE (:Artist {name: line.Name, year: toInteger(line.Year)})<br><br>Commit the current transaction after every 500 rows when importing large amounts of data. |
| LOAD CSV FROM<br>'https://neo4j.com/docs/cypher-refcard/4.2/csv/artists-fieldterminator.csv'<br>AS line FIELDTERMINATOR ';'<br>CREATE (:Artist {name: line\[1\], year: toInteger(line\[2\])})<br><br>Use a different field terminator, not the default which is a comma (with no whitespace around it). |
| LOAD CSV FROM<br>'https://neo4j.com/docs/cypher-refcard/4.2/csv/artists.csv' AS line<br>RETURN DISTINCT file()<br><br>Returns the absolute path of the file that `LOAD CSV` is processing, returns `null` if called outside of `LOAD CSV` context. |
| LOAD CSV FROM<br>'https://neo4j.com/docs/cypher-refcard/4.2/csv/artists.csv' AS line<br>RETURN linenumber()<br><br>Returns the line number that `LOAD CSV` is currently processing, returns `null` if called outside of `LOAD CSV` context. |

  
| Functions [](https://neo4j.com/docs/cypher-manual/4.2/functions) |
| --- |
| coalesce(n.property, $defaultValue)<br><br>The first non-`null` expression. |
| timestamp()<br><br>Milliseconds since midnight, January 1, 1970 UTC. |
| id(nodeOrRelationship)<br><br>The internal id of the relationship or node. |
| toInteger($expr)<br><br>Converts the given input into an integer if possible; otherwise it returns `null`. |
| toFloat($expr)<br><br>Converts the given input into a floating point number if possible; otherwise it returns `null`. |
| toBoolean($expr)<br><br>Converts the given input into a boolean if possible; otherwise it returns `null`. |
| keys($expr)<br><br>Returns a list of string representations for the property names of a node, relationship, or map. |
| properties($expr)<br><br>Returns a map containing all the properties of a node or relationship. |

  
| Spatial functions [](https://neo4j.com/docs/cypher-manual/4.2/functions/spatial) |
| --- |
| point({x: $x, y: $y})<br><br>Returns a point in a 2D cartesian coordinate system. |
| point({latitude: $y, longitude: $x})<br><br>Returns a point in a 2D geographic coordinate system, with coordinates specified in decimal degrees. |
| point({x: $x, y: $y, z: $z})<br><br>Returns a point in a 3D cartesian coordinate system. |
| point({latitude: $y, longitude: $x, height: $z})<br><br>Returns a point in a 3D geographic coordinate system, with latitude and longitude in decimal degrees, and height in meters. |
| distance(point({x: $x1, y: $y1}), point({x: $x2, y: $y2}))<br><br>Returns a floating point number representing the linear distance between two points. The returned units will be the same as those of the point coordinates, and it will work for both 2D and 3D cartesian points. |
| distance(point({latitude: $y1, longitude: $x1}), point({latitude: $y2, longitude: $x2}))<br><br>Returns the geodesic distance between two points in meters. It can be used for 3D geographic points as well. |

  
| Temporal functions [](https://neo4j.com/docs/cypher-manual/4.2/functions/temporal) |
| --- |
| date("2018-04-05")<br><br>Returns a date parsed from a string. |
| localtime("12:45:30.25")<br><br>Returns a time with no time zone. |
| time("12:45:30.25+01:00")<br><br>Returns a time in a specified time zone. |
| localdatetime("2018-04-05T12:34:00")<br><br>Returns a datetime with no time zone. |
| datetime("2018-04-05T12:34:00\[Europe/Berlin\]")<br><br>Returns a datetime in the specified time zone. |
| datetime({epochMillis: 3360000})<br><br>Transforms 3360000 as a UNIX Epoch time into a normal datetime. |
| date({year: $year, month: $month, day: $day})<br><br>All of the temporal functions can also be called with a map of named components. This example returns a date from `year`, `month` and `day` components. Each function supports a different set of possible components. |
| datetime({date: $date, time: $time})<br><br>Temporal types can be created by combining other types. This example creates a `datetime` from a `date` and a `time`. |
| date({date: $datetime, day: 5})<br><br>Temporal types can be created by selecting from more complex types, as well as overriding individual components. This example creates a `date` by selecting from a `datetime`, as well as overriding the `day` component. |
| WITH date("2018-04-05") AS d<br>RETURN d.year, d.month, d.day, d.week, d.dayOfWeek<br><br>Accessors allow extracting components of temporal types. |

  
| Database management [](https://neo4j.com/docs/cypher-manual/4.2/administration/databases) |
| --- |
| CREATE OR REPLACE DATABASE myDatabase<br><br>(★) Create a database named `myDatabase`. If a database with that name exists, then the existing database is deleted and a new one created. |
| STOP DATABASE myDatabase<br><br>(★) Stop the database `myDatabase`. |
| START DATABASE myDatabase<br><br>(★) Start the database `myDatabase`. |
| SHOW DATABASES<br><br>List all databases in the system and information about them. |
| SHOW DATABASE myDatabase<br><br>List information about the database `myDatabase`. |
| SHOW DEFAULT DATABASE<br><br>List information about the default database. |
| DROP DATABASE myDatabase IF EXISTS<br><br>(★) Delete the database `myDatabase`, if it exists. |

  
| User management [](https://neo4j.com/docs/cypher-manual/4.2/administration/security/users-and-roles/#administration-security-users) |
| --- |
| CREATE USER alice SET PASSWORD $password<br><br>Create a new user and a password. This password must be changed on the first login. |
| ALTER USER alice SET PASSWORD $password CHANGE NOT REQUIRED<br><br>Set a new password for a user. This user will not be required to change this password on the next login. |
| ALTER USER alice SET STATUS SUSPENDED<br><br>(★) Change the user status to suspended. Use `SET STATUS ACTIVE` to reactivate the user. |
| ALTER CURRENT USER SET PASSWORD FROM $old TO $new<br><br>Change the password of the logged-in user. The user will not be required to change this password on the next login. |
| SHOW CURRENT USER<br><br>List the currently logged-in user, their status, roles and whether they need to change their password.<br>(★) Status and roles are Enterprise Edition only. |
| SHOW USERS<br><br>List all users in the system, their status, roles and if they need to change their password.<br>(★) Status and roles are Enterprise Edition only. |
| DROP USER alice<br><br>Delete the user. |

    Created at: 2021-02-01T09:26:29+08:00
    Updated at: 2021-02-01T09:26:29+08:00

