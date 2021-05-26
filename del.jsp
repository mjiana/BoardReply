<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
int idx = Integer.parseInt(request.getParameter("idx"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>delete</title>
<link rel="stylesheet" type="text/css" href="boardCSS.css">
</head>
<body>
<form method="post" name="dform" action="del_ok.jsp?idx=<%=idx %>">
<table>
	<tr>
		<td class="t1">게시글의 암호를 입력하세요</td>
	</tr>
	<tr>
		<td><input type="password" class="txt2" name="pwd"></td>
	</tr>
	<tr>
		<td>
			<input type="submit" value="삭제">
			<input type="button"value="돌아가기" onclick="history.back()">
		</td>
	</tr>
</table>
</form>
</body>
</html>