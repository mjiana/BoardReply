<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.util.*, board.*,util.PagingCount"%>
<% request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="boardQuery" class="board.BoardQuery"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>search</title>
<link rel="stylesheet" type="text/css" href="boardCSS.css">
<script type="text/javascript" src="boardScript.js"></script>
</head>
<body>
<%
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

//검색어
String find = request.getParameter("find");
String search = request.getParameter("search");

//검색게시글 수
int rcnt = boardQuery.boardCount(find,search);
PagingCount pc = new PagingCount(rcnt);
%>
<table>
	<tr>
		<td colspan="2"><font>게시판 리스트</font></td>
	</tr>
	<tr>
		<td><font>검색 결과</font></td>
		<td>총 게시글 수 : <%=rcnt %></td>
	</tr>
</table>
<br>
<table>
	<tr>
		<td class="t1">번호</td>
		<td class="t1">일자</td>
		<td class="t2">제목</td>
		<td class="t1">이름</td>
		<td class="t1">조회</td>
	</tr>
	<% 
	//뷰로직, 게시판 목록 불러오기
	Vector list = boardQuery.getSearchList(offset, limit, find, search);
	for(int i=0; i<list.size(); i++){
		BoardBean bb = (BoardBean)list.elementAt(i);
	%>
	<tr>
		<td><%=bb.getIdx() %></td>
		<td><%=bb.getWdate() %></td>
		<td><a href="content.jsp?idx=<%=bb.getIdx() %>"><%=bb.getTitle() %></a></td>
		<td><%=bb.getName() %></td>
		<td><%=bb.getHit() %></td>
	</tr>
	<%
	}//for end
	%>
</table>
<%=pc.showPaging(pagelink, "search.jsp", find, search) %>
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
			<input type="text" name="search" class="txt1" value=<%=search %>>
			<input type="button" value="검색" onclick="send(this.form)">
		</td>
	</tr>
</table>
</form>
<table>
	<tr>
		<td>[<a href="list.jsp">목록으로</a>]</td>
	</tr>
</table>
</body>
</html>