<%@ Language=VBScript %> 
<%


REM (Clarified how data gets from a web form into a script)
REM
REM Another approach to inserting a new record into Oracle table
REM
REM This version below creates the query from web page form variables
REM
REM First declare script variables to hold values before they are passed to SQL query
REM
REM You will need to replace form_text_box_1 etc with the actual names of your form fields

script_variable_1 = request("form_text_box_1")
script_variable_2 = request("form_text_box_2")
script_variable_3 = request("form_text_box_3")
script_variable_4 = request("form_text_box_4")
script_variable_5 = request("form_text_box_5")
script_variable_6 = request("form_text_box_6")
script_variable_7 = request("form_text_box_7")

QueryToRun1 = "INSERT INTO Customer VALUES ('" & script_variable_1 & "','" & script_variable_2 & "','" & script_variable_3 & "','" & script_variable_4 & "','" & script_variable_5 & "','" & script_variable_6 & "','" & script_variable_7 & "')"

Set DBConn = Server.CreateObject("ADODB.Connection")
DBConn.Open "Driver={Oracle in OraClient11g_home1};DBQ=ORCL;UID=ops$pxxxxxxxx;PWD=dd-mm-yy;"
Set QueryResult = DBConn.Execute(QueryToRun1)

REM Next, query the database to see if record was correctly inserted 
REM This over-writes QueryResult, but that's OK as it currently holds no data --

QueryToRun2 = "SELECT * FROM Customer WHERE cust_no = '" & script_variable_1 & "'"

Set QueryResult = DBConn.Execute(QueryToRun2)

REM Put code here that displays query output
REM This can be exactly the same code as used in retrieve.asp

%>
