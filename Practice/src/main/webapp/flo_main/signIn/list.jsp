<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.flo.model.BoardDAO"%>
<%@ page import="com.flo.model.BoardVO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>

<style>
    /* 기본 상태에서 앵커의 언더라인 제거 및 폰트 색상 설정 */
    .board_subject_hover,
    #listTr td.board_writer a,
    .board_pageNum
    {
        text-decoration: none; /* 기본 언더라인 제거 */
        color: #333333; /* 폰트 색상 */
    }

    /* hover 상태에서 언더라인이 생기도록 설정 */
    .board_subject_hover:hover
    {
        text-decoration: underline; /* hover 시 언더라인 추가 */
        color: #333333; /* 폰트 색상 유지 */
    }
    
    #listTr td.board_writer:hover
    {
        text-decoration: underline; /* hover 시 언더라인 추가 */
        color: #333333; /* 폰트 색상 유지 */
    }
    
    .board_pageNum:hover
    {
        text-decoration: underline; /* hover 시 언더라인 추가 */
        color: #333333; /* 폰트 색상 유지 */
    }
</style>

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

<%
	response.setContentType("text/html;charset=UTF-8");
	// String loginID = (String)session.getAttribute("loginID");
	String id = (String)session.getAttribute("id");
%>

<!DOCTYPE html>
<html>
<head>
<title>게시판</title>
<script language="javascript" src="../script.js?timestamp=<%= System.currentTimeMillis() %>"></script>
<script src="https://kit.fontawesome.com/b551008ea2.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../style.css">
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap" rel="stylesheet">
<script language="javascript" src="script.js?timestamp=<%= System.currentTimeMillis() %>"></script>
<script language="javascript" src="Bscript.js?timestamp=<%= System.currentTimeMillis() %>"></script>

</head>





         <br>
		<b id="board_list">글목록(전체 글:<%=count%>)
		</b>
<%
		if (count == 0)
		{	// 보여줄 게시글 없음.
%>
		<table width="700px">
			<tr>
				<td align="center">게시판에 저장된 글이 없습니다.</td>
		</table>
<%
		} else
		{
%>
	<div>
		<ul>
		<li>번호</li>
		<li>제목</li>
		<li>작성자</li>
		<li>작성일</li>
		<li>조회</li>
		<li>IP</li>
		</ul>
	
	</div>

		<table id="bt" border="1" cellpadding="0" cellspacing="0" align="center" style="color: #333333;">
			<tr class="list_table" align="center">
				<td align="center" width="50px" height="5px">번 호</td>
				<td align="center" width="250">제 목</td>
				<td align="center" width="100">작성자</td>
				<td align="center" width="150">작성일</td>
				<td align="center" width="40">조 회</td>
				<!-- <td align="center" width="100">IP</td> -->
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
	<div>
	<ul></ul>
	</div>


			<tr id="listTr">								<!-- 50, 49, 48 ...  -->
			
				<td width="50" class="board_number"><%=number--%></td>
				<td width="250">
				<a href="content.jsp?num=<%=article.getNum()%>&pageNum=1" class="board_subject_hover"> <%-- <%=article.getSubject()%> </a> --%>

<%
				//6. depth값에 따라 5배수를 증가시켜 화면에 출력해야 함.
				// ex) depth가 1이면 => 길이5, 2= >10.
				/* int wid=0;  */
				if(article.getDepth()>0)
				{
					/* wid=5*(article.getDepth()); */
%>
				<img src="images/level.gif" width="5px" height="5px">
				<img src="images/re.gif">
<%
				} else
				{
%>
			 	<img src="images/level.gif" width="5px" height="5px">
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
				<td align="center" width="100" class="board_writer">
				<a href="mailto:<%=article.getEmail()%>"> <%=article.getWriter()%></a>
				</td>
				<td align="center" width="150" class="board_regDate"><%=sdf.format(article.getRegdate())%></td>
				<td align="center" width="50" class="board_readCount"><%=article.getReadcount()%></td>
				<!-- <td align="center" width="100"> <%=article.getIp()%></td> -->

			</tr>
<%
			}
%>
<%
		}
%>
		</table>

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
			<a href="board.jsp?pageNum=<%= i %>" class="board_pageNum">[<%= i %>] </a>
		<% } else
		{%>
		<a href="board.jsp?pageNum=<%= i %>">[<%= i %>]</a>
	<% }%>	
<%
 }
 if (endPage < pageCount) { %>
		<a href="board.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a>
		<%
 }
 }
%>
</div>
    <br>
    <br>