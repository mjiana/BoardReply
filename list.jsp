<%@page import="util.PagingCount"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.util.*, board.*"%>
<jsp:useBean id="boardQuery" class="board.BoardQuery"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>list</title>
<link rel="stylesheet" type="text/css" href="boardCSS.css">
<script type="text/javascript" src="boardScript.js"></script>
</head>
<body>
<%
//총 게시글 수
int rcnt = boardQuery.boardCount();
//페이징 준비
int limit = 10;
int offset = 0;
int pagelink = 1;

String offset_get = request.getParameter("offset");
if(offset_get == null) offset = 0;
else offset = Integer.parseInt(offset_get);

String pagelink_get = request.getParameter("pagelink");
if(pagelink_get == null) pagelink = 1;
else pagelink = Integer.parseInt(pagelink_get);
%>
<table>
	<tr>
		<td class="tc1"><font>게시판 리스트</font></td>
	</tr>
</table>
<br>
<table>
	<tr>
		<td class="right" colspan="5">[<a href="write.jsp">글쓰기</a>]</td>
	</tr>
	<tr>
		<td class="t1">번호</td>
		<td class="t1">일자</td>
		<td class="t2">제목</td>
		<td class="t1">이름</td>
		<td class="t1">조회</td>
	</tr>
	<% 
	//뷰로직, 게시판 목록 불러오기
	Vector list = boardQuery.getBoardList(offset, limit);
	for(int k=0; k<list.size(); k++){
		BoardBean bb = (BoardBean)list.elementAt(k);
	%>
	<tr>
		<td><%=bb.getIdx() %></td>
		<td><%=bb.getWdate() %></td>
		<td class="left2"><%
		if(bb.getDepth() > 0){
			out.print("&nbsp;");
			for(int i=0; i<bb.getDepth(); i++){
				out.print("<font class='f2'>[Re]</font>");
			}
			//out.print("<font class='f2'>[Re]</font>");
		}
		%>
		<a href="content.jsp?idx=<%=bb.getIdx()%>"><%=bb.getTitle() %></a>
		</td>
		<td><%=bb.getName() %></td>
		<td><%=bb.getHit() %></td>
	</tr>
	<%
	}//for end
	%>
	<tr>
		<td colspan="3"></td>
		<td class="right" colspan="5">총 게시글 수 : <%=rcnt %>개</td>
	</tr>
</table>
<%
//페이징
PagingCount pc = new PagingCount(rcnt);
%>
<%=pc.showPaging(pagelink, "list.jsp") %>
<!-- 검색폼 -->
<form method="post" name="sform" action="search.jsp">
<table>
	<tr>
		<td>
			<select name="find">
				<option value="name">이름</option>
				<option value="title" selected="selected">제목</option>
				<option value="content">내용</option>
			</select>
			<input type="text" name="search" class="txt1">
			<input type="button" value="검색" onclick="send(this.form)">
		</td>
	</tr>
</table>
</form>
</body>
</html>