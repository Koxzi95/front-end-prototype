<%@ Language=VBScript %>
<html>
  <head>
    <title>QAL | Copy Catalogue | Counter Staff</title>
	<!--link to the style sheet-->
    <link rel="stylesheet" type="text/css" href="http://my.tech.dmu.ac.uk/~p13198051/css/base.css">
    <link rel="stylesheet" type="text/css" href="http://my.tech.dmu.ac.uk/~p13198051/css/simplegrid.css">
  </head>
  <body>
    <div class="pageheader">
		<!-- insert the logo into the page -->
      <img src="http://my.tech.dmu.ac.uk/~p13198051/img/logo.png" alt="Page Logo" height="175" width="325" align="right">
      <h1>Copy Catalogue - Counter Staff</h1>
    </div>
    
    <div class="grid grid-pad">
      <div class="col-10-12">
        <div class="content">
          <br><br>
          <%
		  REM CONNECTS to the oracle database 
          Set DBConn = Server.CreateObject("ADODB.Connection")
          DBConn.Open "Driver={Oracle in OraClient11g_home1};DBQ=ORCL;UID=ops$p13198051;PWD=06-09-85;"
          REM run the query and store the result in a variable. this query selects all copies from the table copy
		  Set QueryResult = DBConn.Execute("SELECT * FROM COPY")
          REM display the results in a html table using a loop
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
        <button class="buttonsasp" id="btnClear" onClick="location.href = 'http://my.tech.dmu.ac.uk/~p13198051/searchcopy_staff.html'">&nbspSearch Copies&nbsp</button>
        <button class="buttonsRH"  onClick="history.go(-1);return true;">&nbspReturn&nbsp</button>
        <button class="buttonsRH"  onClick="location.href = 'http://my.tech.dmu.ac.uk/~p13198051/help.html'">&nbspHelp&nbsp</button>
      </div>
    </div>
  </div>
  <footer>
  </footer>
</body>
</html>