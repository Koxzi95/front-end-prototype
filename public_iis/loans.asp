<%@ Language=VBScript %>
 <html>
   <head>
       <title>QAL | Loans</title>
       <link rel="stylesheet" type="text/css" href="css/base.css">
   </head>
   <body>
        <header>
            <img src="http://placehold.it/350x150" id="headerlogo" alt="QAL Logo" />
            <!-- header with title and logo set to right -->
            <p id="pagetitle">Home Page</p>
        </header>
         <p>
            <%
 
           Set DBConn = Server.CreateObject("ADODB.Connection")
 DBConn.Open "Driver={Oracle in OraClient11g_home1};DBQ=ORCL;UID=ops$p13201420;PWD=02-07-95;"
            Set QueryResult = DBConn.Execute("SELECT * FROM LOAN")
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

 <footer>
     
     
 </footer>
 
</body>
</html>