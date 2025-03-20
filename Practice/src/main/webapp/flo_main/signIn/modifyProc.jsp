<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.flo.model.*"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="dao" class="com.flo.model.MemberDAO"/>
<jsp:useBean id="mvo" class="com.flo.model.MemberVO">
<jsp:setProperty name="mvo" property="*"/></jsp:useBean>

<%
	String loginID = (String)session.getAttribute("id");
	mvo.setId(loginID);
	dao.updateMember(mvo);
%>

<!DOCTYPE html>
<html>
<head>
<title>Update Process</title>
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<!-- <meta http-equiv="Refresh" content="3;url=login.jsp"> -->
<body>
	<main>
<script>
    alert("회원정보 수정이 완료되었습니다.");
    // 알림 후 signIn.jsp로 자동 이동
    window.location.href = "signIn.jsp";
</script>

		<!-- 	<font size="5" face="바탕체"> 입력하신 내용대로
		<b>회원정보가 수정 되었습니다.</b>
		<br></br>
			3초후에 Logon Page로 이동합니다
		</font> -->
	</main>
</body>
</html>