<%
	
	REM -- Sometimes it is useful to get new input from the user on the same page 
	REM --                       		that shows the output of their last action.
	REM -- This section of code could be added at the end of a query script.
	REM -- It writes a new blank input form for a further query.
	REM -- Note the DOUBLE double quotes - necessary to get a SINGLE double quote into the html output page.
	
		Response.Write "To make another query, enter details in the boxes below and press <b>submit</b>.<br /><br />"
		Response.write "<form method=""post"" action=""http://aspen.tech.dmu.ac.uk/YOUR-P-NUMBER/THIS-SCRIPT.asp"">"
		Response.write "Input field one: <input name=""fm_input1"" type=""text""><br />"
		Response.write "Input field two: <input name=""fm_input2"" type=""text""><br />"
		Response.write "Input field three: <input name=""fm_input3"" type=""text""><br />"
		Response.write "Input field four: <input name=""fm_input4"" type=""text""><br /><br />"
		Response.write "<input name=""Submit this data"" type=""submit"">"
		Response.write "</form>"

	REM -- Alternative routine - display new input form with default values posted from script variables.  
	REM -- The default values could come from an earlier query.  If the user leaves these unchanged
	REM --                                   the script would then run exactly the same query again.
	REM -- Or they could be the RESULTS of a previous SQL query.  (Use QueryResult(1), QueryResult(2) 
	REM --				and so on - instead of sc_value1 etc - to extract single fields from the row of data. 
	REM -- Again note the DOUBLE double quotes - necessary to get a SINGLE double quote into the html output page.
	
		Response.Write "To make another query, enter NEW details in the boxes below and press <b>submit</b>.<br /><br />"
		Response.write "<form method=""post"" action=""http://aspen.tech.dmu.ac.uk/YOUR-P-NUMBER/THIS-SCRIPT.asp"">"
		Response.write "Input field one: <input name=""fm_input1"" type=""text"" value=""" & sc_value1 & """><br />"
		Response.write "Input field two: <input name=""fm_input2"" type=""text"" value=""" & sc_value2 & """><br />"
		Response.write "Input field three: <input name=""fm_input3"" type=""text"" value=""" & sc_value3 & """><br />"
		Response.write "Input field four: <input name=""fm_input4"" type=""text"" value=""" & sc_value4 & """><br /><br />"
		Response.write "<input name=""Submit this data"" type=""submit"">"
		Response.write "</form>"

%>