<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.flo.model.BoardDAO"%>
<%@ page import="com.flo.model.BoardVO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="view/color.jsp"%>
<%-- <%!
	// 전역변수.
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%> --%>
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	// 수정 <1> 1. [페이징 기법]페이지 사이즈 : 1페이지당 10개 출력.
	int pageSize = 20;
	
	// 2. [페이징 기법]페이지 번호 선택. (default : 1page)
	/* request.setCharacterEncoding("UTF-8"); -> 한글일때만 의미 있기 때문에.*/
	request.setCharacterEncoding("UTF-8");
	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null)
	{
		pageNum="1";
	}
	
	// 3. 현재 페이지 설정, start and end.
	int currentPage = Integer.parseInt(pageNum);
	int start = (currentPage-1)*pageSize + 1;	// (시작)4page의 경우 31~40이니까 (4-1)*10 + 1 => 31
	int end = (currentPage)*pageSize;	// (끝)4*10 => 40
%>
<%
	// 4. 해당된 페이지 10개를 가져옴.
	int number = 0;
	
	ArrayList<BoardVO> boardList = null;
	
	BoardDAO bdao = BoardDAO.getInstance();
	
	// 전체 글의 갯수.
	int count = bdao.selectCountDB();

	if (count > 0)
	{
		// 현재 페이지 내용 10개 출력(글의 목록을 num으로 desc)).
	
		boardList = bdao.selectStartEndDB(start, end);
	}
	
	// 5. 4페이지 출력 시, (31~40번)num은 40이 세팅되어야 함. 40-39-38-37-36
	// 전체 갯수 100페이지라면, 1페이지에 (100~91).
	number = count - (currentPage-1)*pageSize;	// 0으로 초기화.
	
	// 6. depth값에 따라 5배수를 증가시켜 화면에 출력해야 함.
	// ex) depth가 1이면 => 길이5, 2= >10.
/* 	int wid = 0;
	if (data.getDepth() > 0)
	{
		wid = 5 * data.getDepth();
	} */
		
	
%>

<!DOCTYPE html>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_c%>">
	<main>
		<b>글목록(전체 글:<%=count%>)
		</b>
		<table width="700">
			<tr>
				<td align="right" bgcolor="<%=value_c%>">
					<a href="writeForm.jsp">글쓰기</a>
				</td>
			</tr>
		</table>
<%
		if (count == 0)
		{	// 보여줄 게시글 없음.
%>
		<table width="700" border="1" cellpadding="0" cellspacing="0">
			<tr>
				<td align="center">게시판에 저장된 글이 없습니다.</td>
		</table>
<%
		} else
		{
%>
		<table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
			<tr height="30" bgcolor="<%=value_c%>">
				<td align="center" width="50">번 호</td>
				<td align="center" width="250">제 목</td>
				<td align="center" width="100">작성자</td>
				<td align="center" width="150">작성일</td>
				<td align="center" width="50">조 회</td>
				<td align="center" width="100">IP</td>
			</tr>
<%
/* 			for (int i = 0; i < articleList.size(); i++) {
				BoardVO article = (BoardVO) articleList.get(i); */
				
/* 				for (BoardVO article : boardList)
				{
					// 6. depth값에 따라 5배수를 증가시켜 화면에 출력해야 함.
					// ex) depth가 1이면 => 길이5, 2= >10.
					int wid = 0;
					if (article.getDepth() > 0)
					{
						wid = 5 * article.getDepth();
					}  */
					
			for (BoardVO article : boardList)
			{
					
%>
			<tr height="30">								<!-- 50, 49, 48 ...  -->
				<td align="center" width="50"><%=number--%></td>
				<td width="250">
				<a href="content.jsp?num=<%=article.getNum()%>&pageNum=1"> <%-- <%=article.getSubject()%> </a> --%>

<%
				//6. depth값에 따라 5배수를 증가시켜 화면에 출력해야 함.
				// ex) depth가 1이면 => 길이5, 2= >10.
				int wid=0; 
				if(article.getDepth()>0)
				{
					wid=5*(article.getDepth());
%>
				<img src="images/level.gif" width="<%=wid%>" height="16">
				<img src="images/re.gif">
<%
				} else
				{
%>
			 	<img src="images/level.gif" width="<%=wid%>" height="16">
<%
				}
%>


<%=article.getSubject() %></a>

<%
				if (article.getReadcount() >= 20)
				{
 %>
 					<img src="images/hot.gif" border="0" height="16">
 <%} %></td>
				<td align="center" width="100">
				<a href="mailto:<%=article.getEmail()%>"> <%=article.getWriter()%></a>
				</td>
				<td align="center" width="150"><%=sdf.format(article.getRegdate())%></td>
				<td align="center" width="50"><%=article.getReadcount()%></td>
				<td align="center" width="100"><%=article.getIp()%></td>
			</tr>
<%
			}
%>
<%
		}
%>
		</table>
	</main>
	<br>
<div align="center">		
<%
 if (count > 0)
 {
	 int pageBlock = 3;
	 int imsi = count % pageSize == 0 ? 0 : 1;
	 int pageCount = count / pageSize + imsi;
	 int startPage = (int)((currentPage-1)/pageBlock)*pageBlock + 1;
	 int endPage = startPage + pageBlock - 1;
	if (endPage > pageCount) endPage = pageCount; 
 	if (startPage > pageBlock)
 {
 %>
		<a href="list.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a>
		<%
 }
 for (int i = startPage ; i <= endPage ; i++) 
{
	 
		if (currentPage == i) 
		{
			%>
			<a href="list.jsp?pageNum=<%= i %>">[[<%= i %>]] </a>
		<% } else
		{%>
		<a href="list.jsp?pageNum=<%= i %>">[<%= i %>]</a>
	<% }%>	
<%
 }
 if (endPage < pageCount) { %>
		<a href="list.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a>
		<%
 }
 }
%>
</div>
</body>
</html>