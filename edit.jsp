<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="board.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시글 수정</title>
<link rel="stylesheet" type="text/css" href="boardCSS.css">
<script type="text/javascript" src="boardScript.js"></script>
</head>
<%
int idx = Integer.parseInt(request.getParameter("idx"));
BoardQuery bq = new BoardQuery();
BoardBean bb = bq.boardView(idx);
%>
<body>
<table>
	<tr>
		<td><font>일반형 게시판</font></td>
	</tr>
</table>
<br>
<form method="post" name="myform" action="edit_ok.jsp">
<table>
	<tr>
		<td colspan="2">게시글 수정</td>
	</tr>
	<tr>
		<td class="t1">이름</td>
		<td><input type="text" name="name" value="<%=bb.getName() %>"></td>
	</tr>
	<tr>
		<td class="t1">이메일</td>
		<td><input type="text" name="email" value="<%=bb.getEmail() %>"></td>
	</tr>
	<tr>
		<td class="t1">홈페이지</td>
		<td><input type="text" name="homepage" value="<%=bb.getHomepage() %>"></td>
	</tr>
	<tr>
		<td class="t1">제목</td>
		<td><input type="text" name="title" value="<%=bb.getTitle() %>"></td>
	</tr>
	<tr>
		<td class="t1">내용</td>
		<td><textarea name="content"><%=bb.getContent() %></textarea></td>
	</tr>
	<tr>
		<td class="t1">암호</td>
		<td><input type="password" name="pwd"></td>
	</tr>
	<tr>
		<td colspan="2">
		<input type="hidden" name="idx" value="<%=bb.getIdx()%>">
		<input type="button" class="btn1" value="수정하기" onclick="trans(this.form)">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="reset" class="btn1" value="다시쓰기">
		</td>
	</tr>
</table>
</form>
<br>
<table>
	<tr>
		<td>[<a href="./content.jsp?idx=<%=bb.getIdx()%>">돌아가기</a>]</td>
	</tr>
</table>
</body>
</html>