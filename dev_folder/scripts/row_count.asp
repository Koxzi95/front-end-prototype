<%@ Language=VBScript %>

<%

REM Point script at first record in result, loop to count total number of rows
REM Final value of RowCount is no of records retrieved by query
REM Can use this to test for unique value in database


RowCount = 0
QueryResult.MoveFirst
Do While not QueryResult.EOF 
	RowCount = RowCount ++1
	QueryResult.MoveNext
Loop
%>