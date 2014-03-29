<%@ Language=VBScript %>
<html>
	<head>
		<title>Added Borrower</title>
		<!--link to the style sheet-->
		<link rel="stylesheet" type="text/css" href="http://my.tech.dmu.ac.uk/~p13198051/css/base.css">
		<link rel="stylesheet" type="text/css" href="http://my.tech.dmu.ac.uk/~p13198051/css/simplegrid.css">
	</head>
	<body>
		<div class="pageheader">
			<!--insert the logo image into the page -->
			<img src="http://my.tech.dmu.ac.uk/~p13198051/img/logo.png" alt="Page Logo" height="175" width="325" align="right">
			<h1>Added Borrower</h1>
		</div>
		<div class="grid grid-pad">
			<div class="col-10-12">
				<div class="content">
					<br><br>
					<%
					REM store the data from the input form in variables
					script_variable_1 = request("bor_id_input")
					script_variable_2 = request("bor_type_input")
					script_variable_3 = request("bor_firstname_input")
					script_variable_4 = request("bor_surname_input_input")
					script_variable_5 = request("bor_add_1_input")
					script_variable_6 = request("bor_add_2_input")
					script_variable_6A = request("bor_add_3_input")
					script_variable_7 = request("bor_tel_input")
					script_variable_8 = request("bor_email_input")
					script_variable_89 = request("bor_status_input")
					REM store the sql query in a variable - Insert the values which are taken from the input form into the table borrowers 
					QueryToRun1 = "INSERT INTO BORROWER VALUES ( '" & script_variable_1 & "' , '" & script_variable_2 & "' , '" & script_variable_3 & "' , '" & script_variable_4 & "' , '" & script_variable_5 & "' , '" & script_variable_6 & "' , '" & script_variable_6A & "' , '" & script_variable_7 & "' , '" & script_variable_8 & "', '" & script_variable_9 & "' )"
					REM connect to the database
					Set DBConn = Server.CreateObject("ADODB.Connection")
					DBConn.Open "Driver={Oracle in OraClient11g_home1};DBQ=ORCL;UID=ops$p13198051;PWD=06-09-85;"
					REM execute the query and store the results in a variable
					Set QueryResult = DBConn.Execute(QueryToRun1)
					REM stores the next query in a variable
					QueryToRun2 = "SELECT * FROM borrower WHERE bor_id = '" & script_variable_1 & "'"
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
				<!--insert the return and help buttons into the page-->
				<button class="buttonsRH" onClick="history.go(-1);return true;">&nbspReturn&nbsp</button>
				<button class="buttonsRH"  onClick="location.href = 'http://my.tech.dmu.ac.uk/~p13198051/help.html'">&nbspHelp&nbsp</button>
			</div>
		</div>