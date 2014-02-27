<%@ Language=VBScript %>
<%

REM 
REM illustrates a way to update an existing record in an Oracle table
REM
REM This script first collects two variables from text boxes on a web form.
REM (This form is in the html page called TestUpdate.html)
REM
REM The text boxes are called form_price and form_menucode, and their values
REM are placed in script variables called query_price and query_menucode
REM
REM The script uses these two values to assemble a query in a script variable called QueryToRun1
REM
REM Then the variable QueryToRun1 (containing the SQL update) is passed to Oracle for execution
REM
REM Finally the script queires the database using a Select query to check the update has worked.
REM
REM The output of this Select query is sent back to the user as a web page table, so they can actually see it.
REM
REM For your script, you need to change the Oracle userid and password.  
REM Also make sure that appropriate text-boxes exist on your form and 
REM that you use appropriate variables in the script to collect the data

query_price = request("form_price")
query_menucode = request("form_menucode")
QueryToRun1 = "UPDATE PIZZA Set pizza_price = '" & query_price & "' WHERE menu_code ='" & query_menucode & "';"

REM Response.Write = "Price is " & query_price & " and pizza no is " & query_menucode & "<br>"

Set DBConn = Server.CreateObject("ADODB.Connection")
DBConn.Open "Driver={Oracle in OraClient11g_home1};DBQ=ORCL;UID=ops$pxxxxxxxx;PWD=dd-mm-yy;"

Set QueryResult = DBConn.Execute(QueryToRun1)

REM Next, we query the database to see if the record was correctly inserted --

QueryToRun2 = "SELECT * FROM Pizza WHERE menu_code ='" & query_menucode & "'"

Set QueryResult = DBConn.Execute(QueryToRun2)

REM -- start of table in which we display the results -->
Response.Write "<table border=1 cellpadding=4><tr>"

FOR I = 0 to QueryResult.Fields.Count --1
	Response.Write "<td><b>" & QueryResult(I).Name & "</b></td>"
	on error resume next
Next

Response.Write "</tr>"

QueryResult.MoveFirst
While not QueryResult.EOF 
	Response.Write "<tr>"
	For I = 0 to QueryResult.Fields.Count --1
		Response.Write "<td><b>" & QueryResult(I) & "</b></td>"
		on error resume next
	Next
	Response.Write "</tr>"
	QueryResult.MoveNext
Wend

Response.Write "</table>"

QueryResult.Close
DBConn.Close

%>