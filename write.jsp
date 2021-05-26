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
<title>�Խ��� �۾���</title>
<link rel="stylesheet" type="text/css" href="boardCSS.css">
<script type="text/javascript" src="boardScript.js"></script>
</head>
<body onload="wform.name.focus()">
<table>
	<tr>
		<td><font>�Ϲ��� �Խ���</font></td>
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
		<% if(idx != 0) out.print("��� ����"); else out.print("�� �۾���"); %>
		</td>
	</tr>
	<tr>
		<td class="t1">�̸�</td>
		<td><input type="text" name="name"></td>
	</tr>
	<tr>
		<td class="t1">�̸���</td>
		<td><input type="text" name="email"></td>
	</tr>
	<tr>
		<td class="t1">Ȩ������</td>
		<td><input type="text" name="homepage"></td>
	</tr>
	<tr>
		<td class="t1">����</td>
		<td><input type="text" name="title" value="<%=bb.getTitle() == null ? "" : bb.getTitle() %>"></td>
	</tr>
	<tr>
		<td class="t1">����</td>
		<td><textarea name="content"><%=bb.getContent() == null ? "" : bb.getContent()  %></textarea></td>
	</tr>
	<tr>
		<td class="t1">��ȣ</td>
		<td><input type="password" name="pwd"></td>
	</tr>
	<tr>
		<td colspan="2">
		<input type="button" value="���ε�" onclick="trans(this.form)">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="reset" value="�ٽþ���">
		</td>
	</tr>
</table>
</form>
<br>
<table>
	<tr>
		<td>[<a href="./list.jsp">����Ʈ</a>]</td>
	</tr>
</table>
</body>
</html>