<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="board.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시글 보기</title>
<link rel="stylesheet" type="text/css" href="boardCSS.css">
<script type="text/javascript" src="boardScript.js"></script>
</head>
<%
int idx = Integer.parseInt(request.getParameter("idx"));
//HitUp
BoardQuery bq = new BoardQuery();
bq.boardHitUp(idx);
BoardBean bb = bq.boardView(idx);
%>
<body>
<table>
	<tr>
		<td><font>일반형 게시판</font></td>
	</tr>
</table>
<br>
<form method="post" name="wform">
<table>
	<tr>
		<td colspan="2">게시글 보기</td>
	</tr>
	<tr>
		<td colspan="2" class="right">조회수 : <%=bb.getHit() %></td>
	</tr>
	<tr>
		<td class="t1">이름</td>
		<td><%=bb.getName() %></td>
	</tr>
	<tr>
		<td class="t1">이메일</td>
		<td><%=bb.getEmail() %></td>
	</tr>
	<tr>
		<td class="t1">홈페이지</td>
		<td><%=bb.getHomepage() %></td>
	</tr>
	<tr>
		<td class="t1">제목</td>
		<td><%=bb.getTitle() %></td>
	</tr>
	<tr>
		<td class="t1">내용</td>
		<td><%=bb.getContent() %></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="button" class="btn1" value="수정하기" onclick="editsend(<%=bb.getIdx()%>)">
			<input type="button" class="btn1" value="삭제하기" onclick="delsend(<%=bb.getIdx()%>)">
			<input type="button" class="btn1" value="답글달기" onclick="location.href='write.jsp?idx=<%=bb.getIdx()%>'">
		</td>
	</tr>
</table>
</form>
<br>
<table>
	<tr>
		<td>[<a href="./list.jsp">리스트</a>]</td>
	</tr>
</table>
</body>
</html>