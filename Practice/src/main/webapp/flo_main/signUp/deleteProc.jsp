<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.flo.model.*"%>

<jsp:useBean id="dao" class="com.flo.model.MemberDAO" />

<!DOCTYPE html>
<html>
<head>

<div class="menu">
        <ul class="menu_contents_left">
            <li><a href="/Practice/flo_main/signIn/main.jsp">FLO</a></li>    <!--폰트 스타일 적용하기.-->
            <li><a href="Flo_Main.html">둘러보기</a></li>
            <li><a href="Flo_Main.html">보관함</a></li>
            <li><a href="Flo_Main.html">이용권</a></li>
        </ul>
        
        <ul class="menu_contents_center">
            <li><i class="fa-solid fa-magnifying-glass"></i><input type="text" name="search" id="search" placeholder="검색어를 입력하세요."></li>
        </ul>

        <ul class="menu_contents_right">
            <li><a href="signIn.jsp">로그인</a></li>
            <li><a href="/Practice/flo_main/signUp/signUp.jsp">회원가입</a></li>
        </ul>
    </div>

<title>회원탈퇴</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	String id = (String) session.getAttribute("loginID");
	String pass = request.getParameter("pass");
	int check = dao.deleteMember(id, pass);
	if (check == 1)
	{
		session.invalidate();
%>
<!-- <meta http-equiv="Refresh" content="3;url=login.jsp"> -->
<body>
	<main>
		<h2> 회원탈퇴가 완료되었습니다.</h2>
		<br></br>
		<h2> 이용해주셔서 감사합니다.</h2>
		<a href="signIn.jsp">이전으로</a>
	</main>
<!-- 	<main>
		<font size="5" face="바탕체"> 회원정보가 삭제되었습니다
		<br></br> 안녕히 가세요 ! ㅠ.ㅠ
		<br></br>
			3초후에 로그인 페이지로 이동합니다
		</font>
	</main> -->
<%
	} else
	{
%>
	<script>
		alert("비밀번호가 맞지 않습니다");
		history.go(-1);
	</script>
<%
	}
%>
</body>
</html>