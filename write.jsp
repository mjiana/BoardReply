<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="board.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="bb" class="board.BoardBean" />
<%
int idx;
if(request.getParameter("idx") != null)
	idx = Integer.parseInt(request.getParameter("idx"));
else idx= 0;

BoardQuery bq = new BoardQuery();
bb = bq.boardView(idx);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시판 글쓰기</title>
<link rel="stylesheet" type="text/css" href="boardCSS.css">
<script type="text/javascript" src="boardScript.js"></script>
</head>
<body onload="wform.name.focus()">
<table>
	<tr>
		<td><font>일반형 게시판</font></td>
	</tr>
</table>
<br>
<form method="post" action="write_ok.jsp" name="wform">
<input type="hidden" name="idx" value="<%=bb.getIdx() %>">
<input type="hidden" name="step" value="<%=bb.getStep() %>">
<input type="hidden" name="ref" value="<%=bb.getRef() %>">
<input type="hidden" name="depth" value="<%=bb.getDepth() %>">
<table>
	<tr>
		<td colspan="2">
		<% if(idx != 0) out.print("답글 쓰기"); else out.print("새 글쓰기"); %>
		</td>
	</tr>
	<tr>
		<td class="t1">이름</td>
		<td><input type="text" name="name"></td>
	</tr>
	<tr>
		<td class="t1">이메일</td>
		<td><input type="text" name="email"></td>
	</tr>
	<tr>
		<td class="t1">홈페이지</td>
		<td><input type="text" name="homepage"></td>
	</tr>
	<tr>
		<td class="t1">제목</td>
		<td><input type="text" name="title" value="<%=bb.getTitle() == null ? "" : bb.getTitle() %>"></td>
	</tr>
	<tr>
		<td class="t1">내용</td>
		<td><textarea name="content"><%=bb.getContent() == null ? "" : bb.getContent()  %></textarea></td>
	</tr>
	<tr>
		<td class="t1">암호</td>
		<td><input type="password" name="pwd"></td>
	</tr>
	<tr>
		<td colspan="2">
		<input type="button" value="업로드" onclick="trans(this.form)">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="reset" value="다시쓰기">
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