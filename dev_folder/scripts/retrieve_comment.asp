<%@ Language=VBScript %> 
<html>
<head>
<title>Template for Oracle data retrieval</title>
</head>


<!-- This version is just commented 'Tom.C' -->

<body>
<center>

<%

REM The next set of lines create the database connection and execute SQL query
REM Remember to insert your own P number and Oracle password!

Set DBConn = Server.CreateObject("ADODB.Connection")
DBConn.Open "Driver={Oracle in OraClient11g_home1};DBQ=ORCL;UID=ops$pxxxxxxxx;PWD=dd-mm-yy;"

Set QueryResult = DBConn.Execute("SELECT * FROM Customer")

REM start of table in which we display the results

Response.Write "<table border=1 cellpadding=4><tr>"

REM start of first header row of output table

Response.Write "<tr>"

REM Fill in the column headers by looping for each field in the table
REM Within each cycle of the loop, write a table cell with the field name in it

FOR I = 0 to QueryResult.Fields.Count - 1
   Response.Write "<td><b>" & QueryResult(I).Name & "</b></td>"
Next

REM End the header row

Response.Write "</tr>"

REM This loop works down the rows of the SQL query output, one record at a time

Do while not QueryResult.EOF 
   Response.Write "<tr>"

REM And this inner loop fills in the field values counting across each row
REM In each cycle of this loop, write a table cell with a field value from current row

   For I = 0 to QueryResult.Fields.Count - 1
      Response.Write "<td><b>" & QueryResult(I) & "</b></td>"
   Next

REM Write end of row, move to next record, loop again if more records

Response.Write "</tr>"
QueryResult.MoveNext
Loop

REM When records are all written, end table

Response.Write "</table>"

REM Close database connection and finish output page

QueryResult.Close
DBConn.Close %>

</center>
</body>
</html>