<%@ Language=VBScript %>
<html>
	<head>
		<title>View Loans</title>
		<!--link to the style sheet-->
		<link rel="stylesheet" type="text/css" href="http://my.tech.dmu.ac.uk/~p13198051/css/base.css">
		<link rel="stylesheet" type="text/css" href="http://my.tech.dmu.ac.uk/~p13198051/css/simplegrid.css">
	</head>
	<body>
		<div class="pageheader">
			<!-- insert the logo into the page -->
			<img src="http://my.tech.dmu.ac.uk/~p13198051/img/logo.png" alt="Page Logo" height="175" width="325" align="right">
			<h1>View Loan Details</h1>
		</div>
		<div class="grid grid-pad">
			<div class="col-10-12">
				<div class="content">
					<br><br>
					<%
					REM take the data from the input form and store it in a variable
					query_borrower_id = request("borrower_id_input")
					REM store the first query in a variable - this query selects the loan information for the requested user and also joins up with the copy and book tables to find out more details on the book that was loaned 
					QueryToRun1 = "SELECT Loan.loan_id, Loan.Loan_issue_date, Loan.Loan_due_date, Loan.Loan_Return_date, Loan.fk1_cop_barcode, book.isbn, book.bk_title, book.bk_author FROM Loan JOIN Copy ON loan.fk1_cop_barcode = cop_barcode JOIN Book on copy.fk1_isbn = book.isbn WHERE Loan.Fk2_Bor_Id =  '" & query_borrower_id & "'"
					REM store the second query in a variable - this query find out the first name and surname of the borrower 
					QueryToRun2 = "SELECT DISTINCT Borrower.bor_id, Borrower.bor_firstname, Borrower.bor_surname FROM borrower WHERE Bor_Id = '" & query_borrower_id & "';"
					Set DBConn = Server.CreateObject("ADODB.Connection")
					DBConn.Open "Driver={Oracle in OraClient11g_home1};DBQ=ORCL;UID=ops$p13198051;PWD=06-09-85;"
					REM run both queries and store the results in a variable
					Set QueryResult = DBConn.Execute(QueryToRun1)
					Set QueryResult2 = DBConn.Execute(QueryToRun2)
					REM display a message containing the borrowers borrower id, firstname and surname 
					Response.Write "<br />"
					Response.Write "<br />"
					Response.write "Here are All Loans for user ID: '"& query_borrower_id & "' "
					Response.Write  "" & QueryResult2(1) & "" & QueryResult2(2) & "."
					Response.Write "<br />"
					Response.Write "<br />"
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
				REM end the query and close the connection
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
	</div>
</body>
</html>