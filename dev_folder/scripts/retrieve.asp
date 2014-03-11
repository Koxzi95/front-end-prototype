<%@ Language=VBScript %>
<html>
<head>
<title>Oracle Retrieve</title>
</head>
<body>
<center>

<%

Set DBConn = Server.CreateObject("ADODB.Connection")
DBConn.Open "Driver={Oracle in OraClient11g_home1};DBQ=ORCL;UID=ops$pxxxxxxxx;PWD=dd-mm-yy;" 
 
Set QueryResult = DBConn.Execute("SELECT * FROM Customer")

Response.Write "<table border=1 cellpadding=4><tr>"

For I = 0 To QueryResult.Fields.Count - 1
  Response.Write "<td><b>" & QueryResult(I).name & "</b></td>"
Next

Response.Write "</tr>"

Do While Not QueryResult.EOF
   Response.Write "<tr>"
   For I = 0 To QueryResult.Fields.Count - 1
      Response.Write "<td>" & QueryResult(I) & "</td>"
   Next
   Response.Write "</tr>"
   QueryResult.MoveNext
Loop

Response.Write "</table>"

QueryResult.Close
DBConn.Close
%>
</center>
</body>
</html>