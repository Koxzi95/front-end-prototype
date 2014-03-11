<%@ Language=VBScript %>
<%


REM INCOMPLETE FOR SOME REASON

REM 
REM illustrates a simple way to insert a new record into Oracle table
REM
REM This version writes query into script variable QueryToRun1
REM
REM then variable QueryToRun is passed to Oracle for execution
REM
REM Note: assumes you know the data values when you write the script!
REM
REM For your scripts, you will need to fetch the values from a form text-box

QueryToRun1 = "INSERT INTO Book VALUES ('11402907', 'LIVE', 'Tolkien', '039.0055', 'The Hobbit', '1970', 'Fantasy')"

Set DBConn = Server.CreateObject("ADODB.Connection")
DBConn.Open "Driver={Oracle in OraClient11g_home1};DBQ=ORCL;UID=ops$pxxxxxxxx;PWD=dd-mm-yy;"

Set QueryResult = DBConn.Execute(QueryToRun1)

REM Next, query the database to see if record was correctly inserted --

QueryToRun2 = "SELECT * FROM Book WHERE isbn = '11402907'"

Set QueryResult = DBConn.Execute(QueryToRun2)

REM -- needs code here to display query output

%>