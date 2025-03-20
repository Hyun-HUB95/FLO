<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.flo.model.BoardVO"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="view/color.jsp"%>
<%
int currentPage = (Integer)request.getAttribute("currentPage");
int startRow = (Integer)request.getAttribute("startRow");
int endRow= (Integer)request.getAttribute("endRow");
int count = (Integer)request.getAttribute("count");
int pageSize= (Integer)request.getAttribute("pageSize");
int number = (Integer)request.getAttribute("number");
List<BoardVO> articleList =(List<BoardVO>)request.getAttribute("articleList");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>
<%@page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOARD MAIN</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<link href="BoardTest.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../style.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/b551008ea2.js" crossorigin="anonymous"></script>
<script language="javascript" src="Bscript.js?timestamp=<%= System.currentTimeMillis() %>"></script>
</head>
<div class="menu">
    <ul class="menu_contents_left">
        <li><a href="main.jsp" class="logo">FLO</a></li>    <!--폰트 스타일 적용하기.-->
        <li><a href="writeForm.jsp">게시판</a></li>
        <li><a href="main.jsp">보관함</a></li>
            <li><a href="main.jsp">이용권</a></li>
        </ul>
        
        <ul class="menu_contents_center">
            <li><i class="fa-solid fa-magnifying-glass"></i><input type="text" name="search" id="search" placeholder="       검색어를 입력하세요."></li>
        </ul>

        <ul class="menu_contents_right">
            <li><a href="signIn.jsp">로그인</a></li>       
            <li><a href="signUp.jsp">회원가입</a></li>
        </ul>
    </div>
<body>

<b>글목록(전체 글:<%=count%>)</b>
<table width="700">
  <tr>
    <td align="right" bgcolor="<%=value_c%>">
    <a href="writeForm.do">글쓰기</a>
    </td>
  </tr>
</table>
<%
    if (count == 0)
    {
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr>
    <td align="center">
    게시판에 저장된 글이 없습니다.
    </td>
</table>
<%  } else {    %>
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
    <tr height="30" bgcolor="<%=value_c%>"> 
      <td align="center"  width="50"  >번 호</td> 
      <td align="center"  width="250" >제   목</td> 
      <td align="center"  width="100" >작성자</td>
      <td align="center"  width="150" >작성일</td> 
      <td align="center"  width="50" >조 회</td> 
      <td align="center"  width="100" >IP</td>    
    </tr>
<%  
    for ( BoardVO article : articleList) {
%>
   <tr height="30">
    <td align="center"  width="50" > <%= number--%></td>
    <td  width="250" >
    <!-- 수정 <5> -->
    <a href="content.do?num=<%=article.getNum()%>&pageNum=1">
	 <!-- 수정<6> -->
<%
			//6. depth 값에 따라서 5배수 증가를 해서 화면에 보여줘야된다.
			//depth : 1 => 길이 : 5, 2 => 10
      int wid=0; 
      if(article.getDepth()>0){
        wid=5*(article.getDepth());
%>
       <img src="images/level.gif" width="<%=wid%>" height="16">
       <img src="images/re.gif">
<%    }else{%>
       <img src="images/level.gif" width="<%=wid%>" height="16">
<%}%>
          <%=article.getSubject()%></a> 
          <% if(article.getReadcount()>=20){%>
         <img src="images/hot.gif" border="0"  height="16"><%}%> </td>
    <td align="center"  width="100"> 
       <a href="mailto:<%=article.getEmail()%>">
		<%=article.getWriter()%></a></td>
    <td align="center"  width="150">
		<%= sdf.format(article.getRegdate())%></td>
    <td align="center"  width="50"><%=article.getReadcount()%></td>
    <td align="center" width="100" ><%=article.getIp()%></td>
  </tr>
     <%}%>
<%}%>
</table>
</main>
<br><br>
<!-- 수정 <7> -->
<div align="center">
<%    if (count > 0) {
      int pageBlock = 3;    //보여줄페이지
      int imsi = count % pageSize == 0 ? 0 : 1;
      int pageCount = count / pageSize + imsi;
      int startPage = (int)((currentPage-1)/pageBlock)*pageBlock + 1;
      int endPage = startPage + pageBlock - 1;
      if (endPage > pageCount) endPage = pageCount;  
      if (startPage > pageBlock) {    %>
      <a href="list.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a>

<%    }
      for (int i = startPage ; i <= endPage ; i++) {
    	  if(currentPage == i){
%>
    		  <a href="list.do?pageNum=<%= i %>">[{<%= i %>}]</a>
<%    	}else{ %>
    		   <a href="list.do?pageNum=<%= i %>">[<%= i %>]</a>
<%  	  } %>
       
<%
      }
      if (endPage < pageCount) {  %>
      <a href="list.do?pageNum=<%=startPage+pageBlock%>">[다음]</a>
<%
        }
    }
%>
</div>

    <div id="fixed_icons_bar"></div>
    
    <div id="fixed_icons">
        <i class="fa-solid fa-play fa-2x" id="play_button" style="color: #333333;"></i>
        <i class="fa-solid fa-forward-step fa-2x" id="forward_button" style="color: #333333;"></i>
        <i class="fa-solid fa-backward-step fa-2x" id="backward_button" style="color: #333333;"></i>
        <!-- <a href="main.html"><span id=up_fixed><i class="fa-solid fa-arrow-up fa-2x"></i></span></a>
        <a href="main.html"><span id=settings_fixed><i class="fa-solid fa-gear fa-2x"></i></span></a> -->
    </div>

    <br>
    <br>
    <hr id="footer_top">

   <footer>
       <div id="first">
           <ul id="first_ul">
               <li>　　　　　　　　　　　고객센터</li>
               <li>　　　　　　　　　　　공지사항</li>
               <li>　　　　　　　　　　　</li>
               <li>　　　　　　　　　　　</li>
           </ul>
       </div>

       <div id="second">
           <ul id="second_ul">
               <li>FLO 서비스</li>
               <li>FLO 크리에이터 스튜디오</li>
               <li>FLO 플레이어 다운로드</li>
               <li>서비스 소개</li>
           </ul>
       </div>

       <div id="third">
           <ul id="third_ul">
               <li>기업 정보</li>
               <li>회사소개</li>
               <li>인재 채용</li>
               <li>　</li>
           </ul>
       </div>

       <div id="fourth">
           <ul id="fourth_ul">
               <li>문의</li>
               <li>마케팅・광고・제휴 문의</li>
               <li>서비스 이용 문의</li>
               <li>음원 유통 문의</li>
           </ul>
       </div>
   </footer>
</body>
</html>