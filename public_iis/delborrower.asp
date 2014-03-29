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
			<!-- insert the logo into the page -->
			<img src="http://my.tech.dmu.ac.uk/~p13198051/img/logo.png" alt="Page Logo" height="175" width="325" align="right">
			<h1>Added Borrower</h1>
		</div>
		<div class="grid grid-pad">
			<div class="col-10-12">
				<div class="content">
					<br><br>
					<%
					REM store the data from the input form in variables
					script_variable_1 = request("borrower_id_input")
					REM store the sql query in a variable. this query deletes a borrower from the table borrower where the borrower ID matches the user input
					QueryToRun1 = "DELETE FROM Borrower WHERE Bor_id = ( '" & script_variable_1 & "' )"
					REM connect to the database
					Set DBConn = Server.CreateObject("ADODB.Connection")
					DBConn.Open "Driver={Oracle in OraClient11g_home1};DBQ=ORCL;UID=ops$p13198051;PWD=06-09-85;"
					REM execute the query and store the results in a variable
					Set QueryResult = DBConn.Execute(QueryToRun1)
					Response.Write "You Have Deleted: '"& script_variable_1 & "'  "
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
	</body>
</html>		