<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="board.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խñ� ����</title>
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
		<td><font>�Ϲ��� �Խ���</font></td>
	</tr>
</table>
<br>
<form method="post" name="wform">
<table>
	<tr>
		<td colspan="2">�Խñ� ����</td>
	</tr>
	<tr>
		<td colspan="2" class="right">��ȸ�� : <%=bb.getHit() %></td>
	</tr>
	<tr>
		<td class="t1">�̸�</td>
		<td><%=bb.getName() %></td>
	</tr>
	<tr>
		<td class="t1">�̸���</td>
		<td><%=bb.getEmail() %></td>
	</tr>
	<tr>
		<td class="t1">Ȩ������</td>
		<td><%=bb.getHomepage() %></td>
	</tr>
	<tr>
		<td class="t1">����</td>
		<td><%=bb.getTitle() %></td>
	</tr>
	<tr>
		<td class="t1">����</td>
		<td><%=bb.getContent() %></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="button" class="btn1" value="�����ϱ�" onclick="editsend(<%=bb.getIdx()%>)">
			<input type="button" class="btn1" value="�����ϱ�" onclick="delsend(<%=bb.getIdx()%>)">
			<input type="button" class="btn1" value="��۴ޱ�" onclick="location.href='write.jsp?idx=<%=bb.getIdx()%>'">
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