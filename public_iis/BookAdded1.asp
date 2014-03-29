<%@ Language=VBScript %>
<html>
	<head>
		<title>Added Book</title>
		<!--link to the style sheet-->
		<link rel="stylesheet" type="text/css" href="http://my.tech.dmu.ac.uk/~p13198051/css/base.css">
		<link rel="stylesheet" type="text/css" href="http://my.tech.dmu.ac.uk/~p13198051/css/simplegrid.css">
	</head>
	<body>
		<div class="pageheader">
			<!-- insert the logo into the page -->
			<img src="http://my.tech.dmu.ac.uk/~p13198051/img/logo.png" alt="Page Logo" height="175" width="325" align="right">
			<h1>Added Book</h1>
		</div>
		<div class="grid grid-pad">
			<div class="col-10-12">
				<div class="content">
					<br><br>
					<%
					REM store the data from the input form in variables
					script_variable_1 = request("isbn_input")
					script_variable_2 = request("bk_author_input")
					script_variable_3 = request("bk_title_input")
					script_variable_4 = request("bk_publisher_input")
					script_variable_5 = request("bk_pub_yr_input")
					script_variable_6 = request("bk_shelf_no_input")
					script_variable_7 = request("bk_edition_no_input")
					script_variable_8 = request("bk_genre_code_input")
					REM store the sql query in a variable
					QueryToRun1 = "INSERT INTO Book VALUES ( '" & script_variable_1 & "' , '" & script_variable_2 & "' , '" & script_variable_3 & "' , '" & script_variable_4 & "' , '" & script_variable_5 & "' , '" & script_variable_6 & "' , '" & script_variable_7 & "' , '" & script_variable_8 & "' )"
					REM connect to the database
					Set DBConn = Server.CreateObject("ADODB.Connection")
					DBConn.Open "Driver={Oracle in OraClient11g_home1};DBQ=ORCL;UID=ops$p13198051;PWD=06-09-85;"
					REM execute the query and store the results in a variable
					Set QueryResult = DBConn.Execute(QueryToRun1)
					REM stores the next query in a variable
					QueryToRun2 = "SELECT * FROM book WHERE isbn = '" & script_variable_1 & "'"
					REM execute the query and store the results in a variable
					Set QueryResult = DBConn.Execute(QueryToRun2)
					REM display the results in a table using a loop
					Response.Write "You Have Added: "
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
				REM finish the query and close the connection
				QueryResult.Close
				DBConn.Close
				%>
			</div>
		</div>
		<div class="col-2-12">
			<div class="content">
				<!--inserts the user buttons onto the page -->
				<button class="buttonsRH" onClick="history.go(-1);return true;">&nbspReturn&nbsp</button>
				<button class="buttonsRH"  onClick="location.href = 'http://my.tech.dmu.ac.uk/~p13198051/help.html'">&nbspHelp&nbsp</button>
			</div>
		</div>