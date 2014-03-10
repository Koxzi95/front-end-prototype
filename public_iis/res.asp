<%@ Language=VBScript %>
 <html>
   <head>
       <title>QAL | Reservations</title>
       <link rel="stylesheet" type="text/css" href="css/base.css">
   </head>
   <body>
        <div class="pageheader">
            <img src="img/logo.png" alt="Page Logo" height="175" width="325" align="right"> 
            <h1>Admin Panel</h1>
        </div>             
       <aside> <!-- this is on every data page, contains the controls for the relevant page -->
           <form id="res-search">
               <input type="text" autocomplete="off" autofocus="off" placeholder="Search">
       </form>
       <form id="res-new">
       <input type="text" autocomplete="off" autofocus="off" placeholder="New Reservation">
       </form>
     </aside>
            <%
            Set DBConn = Server.CreateObject("ADODB.Connection")
            DBConn.Open "Driver={Oracle in OraClient11g_home1};DBQ=ORCL;UID=ops$p13201420;PWD=02-07-95;"
            Set QueryResult = DBConn.Execute("SELECT * FROM RESERVATION")
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
            <button class="home-admin-buttons" onClick="location.href = 'http://my.tech.dmu.ac.uk/~p13201420/help.html'">uman.asp</button>
        </footer>
</body>
</html>