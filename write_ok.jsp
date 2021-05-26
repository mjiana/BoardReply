<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="board.*"%>
<% request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="boardBean" class="board.BoardBean"/>
<jsp:setProperty property="*" name="boardBean"/>
<jsp:useBean id="boardQuery" class="board.BoardQuery"/>
<% 
boolean result = false;
result = boardQuery.boardInsert(boardBean); 
if(result){
%>
	<script type="text/javascript">
		alert("입력되었습니다.");
		location.href="list.jsp";
	</script>
<%
}else{
%>
	<script type="text/javascript">
		alert("입력에 실패했습니다.");
		history.back();
	</script>
<%
}
%>