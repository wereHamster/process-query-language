
Process Query Language
----------------------

PQL is a query language for processes running on a system. The syntax
is closely related to the one used in MongoDB. This is because at heart, PQL
uses Plucky. But instead of sending the queries to a MongoDB server, they
are intercepted and processed by PQL.

PQL extends the Process class with four new methods:

 * find - find a process by PID
 * where - find processes which match a query
 * remove - remove (kill) processes
 * count - count processes

These `where` method returns a Plucky::Query object. This object
can be used to further refine the query by chaining additional methods.
Consult the Plucky documentation to see which methods are available.


Supported fields
----------------

There is a limited number of fields which can be used in queries. The
following fields are supported:

 :pid, :rss, :command

The following operators are supported

 gt, gte, lt, lte, in, nin

Use of an unknown field or unknown operator will raise an exception.


Example
-------

This will print the number of unicorn rails workers which use more than
20MB of RSS:

    require 'rubygems'
    require 'process-query-language'
    
    query = Process.where(:rss.gt => 20_000_000)
    query.where(:command => /unicorn_rails.worker/)
    puts query.count


License
-------

Copyright (c) 2010 by Tomas "wereHamster" Carnecky (tomas.carnecky@gmail.com)
