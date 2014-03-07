<%@ Language=VBScript %>
 <html>
   <head>
       <title>QAL | Book Catalogue</title>
       <link rel="stylesheet" type="text/css" href="css/base.css">
   </head>
   <body>
        <div class="headerdiv">
        <header>
            <img src="http://placehold.it/350x150" id="loginlogo" alt="QAL Logo" />
            <!-- header with title and logo set to right -->
            <h1 id="pagetitle">Book Catalogue</h1>
        </header>
        </div>
       
       
       <!-- HTML -->
       
        <%

        Set DBConn = Server.CreateObject("ADODB.Connection")
        DBConn.Open "Driver={Oracle in OraClient11g_home1};DBQ=ORCL;UID=ops$p13201420;PWD=02-07-95;" 

        Set QueryResult = DBConn.Execute("SELECT * FROM BOOK")

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

 <footer>
   
   
 </footer>
 
</body>
</html>