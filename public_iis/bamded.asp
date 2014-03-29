<%@ Language=VBScript %>
<html>
	<head>
		<title>Borrower Amended</title>
		<!--link to the style sheet-->
		<link rel="stylesheet" type="text/css" href="http://my.tech.dmu.ac.uk/~p13198051/css/base.css">
		<link rel="stylesheet" type="text/css" href="http://my.tech.dmu.ac.uk/~p13198051/css/simplegrid.css">
	</head>
	<body>
		<div class="pageheader">
			<!--insert the logo image into the page -->
			<img src="http://my.tech.dmu.ac.uk/~p13198051/img/logo.png" alt="Page Logo" height="175" width="325" align="right">
			<h1>Borrower Amended</h1>
		</div>
		<div class="grid grid-pad">
			<div class="col-10-12">
				<div class="content">
					<%
					REM get the input from the previous form and store it in variables
					new_bor_id = request("bor_id_input")
					new_bor_type_id = request("bor_type_id_input")
					new_bor_firstname = request("bor_firstname_input")
					new_bor_surname = request("bor_surname_input")
					new_bor_address_1 = request("bor_address_1_input")
					new_bor_address_2 = request("bor_address_2_input")
					new_bor_address_3 = request("bor_address_3_input")
					new_bor_tel = request("bor_tel_input")
					new_bor_email =  request("bor_tel_input")
					new_bor_status = request("bor_status_input")
					REM store the first sql query in a variable - this query actually updates the borrwer details in the database 
					QueryToRun = "UPDATE borrower SET fk1_bor_type_id = '" & new_bor_type_id & "', bor_firstname =  '" & new_bor_firstname & "', bor_surname= '" & new_bor_surname & "', bor_address_1= '" & new_bor_address_1 & "', bor_address_2= '" & new_bor_address_2 & "', bor_address_3= '" & new_bor_address_3 & "', bor_tel= '" & new_bor_tel & "', bor_email= '" & new_bor_email & "', bor_status= '" & new_bor_status & "' WHERE bor_id = '" & new_bor_id & "'"
					REM connect to the database
					Set DBConn = Server.CreateObject("ADODB.Connection")
					DBConn.Open "Driver={Oracle in OraClient11g_home1};DBQ=ORCL;UID=ops$p13198051;PWD=06-09-85;"
					REM execute the query and save the result in a variable
					Set QueryResult = DBConn.Execute(QueryToRun)
					REM store the second query in a variable - this query will be used to display result to the user 
					QueryToRun2 = "SELECT * FROM borrower where bor_id = '" & new_bor_id & "'"
					REM execute the second query and store the result in a variable
					Set QueryResult = DBConn.Execute(QueryToRun2)
					Response.Write "You Have Updated: "
					REM display the results in a table using a loop
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
				rem end the query and close the database connection
				QueryResult.Close
				DBConn.Close
				%>
			</div>
		</div>
		<div class="col-2-12">
			<div class="content">
				<!--insert the return and help buttons-->
				<button class="buttonsRH" onClick="history.go(-1);return true;">&nbspReturn&nbsp</button>
				<button class="buttonsRH"  onClick="location.href = 'http://my.tech.dmu.ac.uk/~p13198051/help.html'">&nbspHelp&nbsp</button>
			</div>
		</div>
	</body>
</html>