<%@ Language=VBScript %>
<html>
    <head>
        <title>QAL | Fines | Counter Staff</title>
		<!--link to the style sheet-->
        <link rel="stylesheet" type="text/css" href="http://my.tech.dmu.ac.uk/~p13198051/css/base.css">
        <link rel="stylesheet" type="text/css" href="http://my.tech.dmu.ac.uk/~p13198051/css/simplegrid.css">
    </head>
    <body>
        <div class="pageheader">
			<!-- insert the logo into the page -->
            <img src="http://my.tech.dmu.ac.uk/~p13198051/img/logo.png" alt="Page Logo" height="175" width="325" align="right">
            <h1>Fines - Library Staff</h1>
        </div>
        <div class="grid grid-pad">
            <div class="col-10-12">
                <div class="content">
                    <br><br>
                    <%
					REM connect to the oracle database
                    Set DBConn = Server.CreateObject("ADODB.Connection")
                    DBConn.Open "Driver={Oracle in OraClient11g_home1};DBQ=ORCL;UID=ops$p13198051;PWD=06-09-85;"
                    REM run the query and store the result in a variable. this query selects all fines from the fine table
					Set QueryResult = DBConn.Execute("SELECT * FROM FINE")
                    REM display the query results in a html table using a loop
					Response.Write "<table border=1 cellspacing=0px cellpadding=4>"
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
                    REM end the query and close the database connection
					QueryResult.Close
                    DBConn.Close
                    %>
                </div>
            </div>
            <div class="col-2-12">
                <div class="content">
					<!--inserts the user buttons onto the page -->
                    <button class="buttonsasp" id="btnClear" onClick="location.href = 'http://my.tech.dmu.ac.uk/~p13198051/searchfines_staff.html'">&nbspSearch&nbsp</button>
                    <button class="buttonsasp" id="btnClear" onClick="location.href = 'http://my.tech.dmu.ac.uk/~p13198051/addfine.html'">&nbspAdd&nbsp</button>
                    <button class="buttonsasp" id="btnClear" onClick="location.href = 'http://my.tech.dmu.ac.uk/~p13198051/editfine.html'">&nbspEdit&nbsp</button>
                    <button class="buttonsasp" id="btnClear" onClick="location.href = 'http://my.tech.dmu.ac.uk/~p13198051/delfine.html'">&nbspDelete&nbsp</button>
                    <button class="buttonsRH" onClick="history.go(-1);return true;">&nbspReturn&nbsp</button>
                    <button class="buttonsRH" onClick="location.href = 'http://my.tech.dmu.ac.uk/~p13198051/help.html'">&nbspHelp&nbsp</button>
                </div>
            </div>
            <footer>
                
                
            </footer>
            
        </body>
    </html>