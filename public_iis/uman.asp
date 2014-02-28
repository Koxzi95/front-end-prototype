<%@ Language=VBScript %>
 <html>
   <head>
         <title> Query Output </title>
   </head>
   <body>
         <h1>And here are the results:-</h1>
         <p>
            <%
 
           Set DBConn = Server.CreateObject("ADODB.Connection")
 DBConn.Open "Driver={Oracle in OraClient11g_home1};DBQ=ORCL;UID=ops$p1318954x;PWD=02-07-95;"
            Set QueryResult = DBConn.Execute("SELECT * FROM tab")
           Response.Write "<table border=1 cellpadding=4>"
            Response.Write "<tr>"
            For I = 0 to QueryResult.Fields.Count - 1
                 Response.Write "<td><b>" & QueryResult(I).Name & "</b></td>"
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
 
</body>
</html>