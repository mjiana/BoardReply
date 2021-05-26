<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"  import="mydb.poolfact.ConnectionPool" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<% ConnectionPool pool = ConnectionPool.getInstance(); %>
<p>콘솔창 확인하기</p>
==a connection was created가 4번 나와야 정상이다.

</body>
</html>