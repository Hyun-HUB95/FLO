<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.flo.model.*"%>

<jsp:useBean id="dao" class="com.flo.model.MemberDAO" />

<!DOCTYPE html>
<html>
<head>
<title>회원탈퇴</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	String id = (String) session.getAttribute("id");
	String pass = request.getParameter("pwd");
	int check = dao.deleteMember(id, pass);
	if (check == 1)
	{
		session.invalidate();
%>
<!-- <meta http-equiv="Refresh" content="3;url=login.jsp"> -->
<body>
	<main>
	
	<script>
    alert("회원탈퇴가 완료되었습니다. \n이용해주셔서 감사합니다.");
    // 알림 후 signIn.jsp로 자동 이동
    window.location.href = "main.jsp";
</script>
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