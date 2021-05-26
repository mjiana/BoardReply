<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("euc-kr");  %>  
<jsp:useBean id="bq" class="board.BoardQuery"/>
<%
int idx = Integer.parseInt(request.getParameter("idx"));
String pwd = request.getParameter("pwd");
boolean result = false;
result = bq.boardDelete(idx, pwd);
if(result){
%>
	<script type="text/javascript">
		alert("글이 삭제되었습니다.");
		location.href="list.jsp";
	</script>
<%
}else{
%>
	<script type="text/javascript">
		alert("암호가 일치하지 않습니다.");
		history.back();
	</script>
<%
}
%>
