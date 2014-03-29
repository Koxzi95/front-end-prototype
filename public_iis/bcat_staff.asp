<%@ Language=VBScript %>
<html>
  <head>
    <title>QAL | Book Catalogue | Counter Staff</title>
	<!--link to the style sheet-->
    <link rel="stylesheet" type="text/css" href="http://my.tech.dmu.ac.uk/~p13198051/css/base.css">
    <link rel="stylesheet" type="text/css" href="http://my.tech.dmu.ac.uk/~p13198051/css/simplegrid.css">
  </head>
  <body>
    <div class="pageheader">
		<!-- insert the logo into the page -->
      <img src="http://my.tech.dmu.ac.uk/~p13198051/img/logo.png" alt="Page Logo" height="175" width="325" align="right">
      <h1>Book Catalogue - Counter Staff</h1>
    </div>
    
    <div class="grid grid-pad">
      <div class="col-10-12">
        <div class="content">
          <br><br>
          <%
		  REM CONNECT TO THE DATABASE
          Set DBConn = Server.CreateObject("ADODB.Connection")
          DBConn.Open "Driver={Oracle in OraClient11g_home1};DBQ=ORCL;UID=ops$p13198051;PWD=06-09-85;"
           REM execut the query and store the result in the variable. this query returns all entries in the book datastore 
		  Set QueryResult = DBConn.Execute("SELECT * FROM BOOK")
          REM display the results of the result in a html table, using a loop
		  Response.Write "<table border=1 cellspacing=0px cellpadding=4><tr>"
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
		REM end the query and close the database connection
        QueryResult.Close
        DBConn.Close
        %>
      </div>
    </div>
    <div class="col-2-12">
      <div class="content">
		<!--inserts the user buttons onto the page -->
        <button class="buttonsasp" id="btnClear" onClick="location.href = 'http://my.tech.dmu.ac.uk/~p13198051/searchbook_staff.html'">&nbspSearch Books&nbsp</button>
        <button class="buttonsasp" id="btnClear" onClick="location.href = 'http://aspen.dmu.ac.uk/p13198051/copy_staff.asp'">&nbspView Copies&nbsp</button>
        <button class="buttonsRH"  onClick="history.go(-1);return true;">&nbspReturn&nbsp</button>
        <button class="buttonsRH"  onClick="location.href = 'http://my.tech.dmu.ac.uk/~p13198051/help.html'">&nbspHelp&nbsp</button>
      </div>
    </div>
  </div>
  <footer>
  </footer>
</body>
</html>