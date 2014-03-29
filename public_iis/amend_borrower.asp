<%@ Language=VBScript %>
<html>
	<head>
		<title>Update Borrower Details</title>
		<!--link to the style sheet-->
		<link rel="stylesheet" type="text/css" href="http://my.tech.dmu.ac.uk/~p13198051/css/base.css">
		<link rel="stylesheet" type="text/css" href="http://my.tech.dmu.ac.uk/~p13198051/css/simplegrid.css">
	</head>
	<body>
		<div class="pageheader">
			<!--insert the logo image into the page -->
			<img src="http://my.tech.dmu.ac.uk/~p13198051/img/logo.png" alt="Page Logo" height="175" width="325" align="right">
			<h1>Update Borrower Details</h1>
		</div>
		<div class="grid grid-pad">
			<div class="col-10-12">
				<div class="content">
					<br><br>
					<div class ="form">
						<p>Please make the necessary changes and press Save Changes</p>
						<%
						REM Assign the input from the form to a variable
						query_borrower_id = request("borrower_id_input")
						REM connect to the database
						Set DBConn = Server.CreateObject("ADODB.Connection")
						DBConn.Open "Driver={Oracle in OraClient11g_home1};DBQ=ORCL;UID=ops$p13198051;PWD=06-09-85;"
						REM define the sql query in a variable
						QueryToRun = "SELECT * FROM Borrower WHERE bor_id = '" & query_borrower_id & "'"
						REM execute the query and store the result in a variable
						Set QueryResult = DBConn.Execute(QueryToRun)
						REM create a new form, writing in the results of the previous query
						Response.write "<form method=""post"" action=""http://aspen.dmu.ac.uk/p13198051/bamded.asp"">"
							Response.write "<label for=""bor_id_input"">Borrower ID: </label> <input name=""bor_id_input"" type=""text"" readonly value=""" & query_borrower_id & """ ><br />"
							Response.write "<label for=""bor_type_id_input"">Borrower Type: </label> <input name=""bor_type_id_input"" type=""text"" value=""" &  QueryResult(1)  & """ ><br />"
							Response.write "<label for=""bor_firstname_input"">First Name: </label> <input name=""bor_firstname_input"" type=""text"" value=""" &  QueryResult(2)  & """ ><br />"
							Response.write "<label for=""bor_surname_input"">Surname: </label> <input name=""bor_surname_input"" type=""text"" value=""" &  QueryResult(3)  & """ ><br />"
							Response.write "<label for=""bor_address_1_input"">Address 1: </label> <input name=""bor_address_1_input"" type=""text"" value=""" &  QueryResult(4)  & """ ><br />"
							Response.write "<label for=""bor_address_2_input"">Address 2: </label> <input name=""bor_address_2_input"" type=""text"" value=""" &  QueryResult(5)  & """ ><br />"
							Response.write "<label for=""bor_address_3_input"">Address 3: </label> <input name=""bor_address_3_input"" type=""text"" value=""" &  QueryResult(6)  & """ ><br />"
							Response.write "<label for=""bor_tel_input"">Telephone Number: </label> <input name=""bor_tel_input"" type=""text"" value=""" &  QueryResult(7)  & """ ><br />"
							Response.write "<label for=""bor_email_input"">E-mail Address: </label> <input name=""bor_email_input"" type=""text"" value=""" &  QueryResult(8)  & """ ><br />"
							Response.write "<label for=""bor_status_input"">Status: </label> <input name=""bor_status_input"" type=""text"" value=""" &  QueryResult(9)  & """ ><br />"
							Response.write "<input name=""Save Changes"" type=""submit"" value=""Save Changes""><br />"
						Response.write "</form>"
						%>
					</div>
				</div>
			</div>
			<div class="col-2-12">
				<div class="content">
					<!--insert the return and help buttons into the page -->
					<button class="buttonsRH" onClick="history.go(-1);return true;">&nbspReturn&nbsp</button>
					<button class="buttonsRH"  onClick="location.href = 'http://my.tech.dmu.ac.uk/~p13198051/help.html'">&nbspHelp&nbsp</button>
				</div>
			</div>
		</body>
	</html>