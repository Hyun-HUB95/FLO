<%@page import="com.flo.model.MemberVO"%>
<%@page import="com.flo.model.MemberDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 1. 사용자 정보를 가져온다. -->
<!-- 2. CRUD. -->
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	
	// VO 호출.
	MemberVO mvo = new MemberVO();
	mvo.setId(id);
	
	// DAO 호출. useBeans로 가져와도 됨.
	MemberDAO mdao = new MemberDAO();
	boolean flag = mdao.selectIdCheck(mvo);
%>

<!-- 3. 화면 설계. -->
<!DOCTYPE html>
<html>
<head>
<title>ID중복체크</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
</head>
	<br>
	<main>
		<b><%=id%></b>
		<%
		if (flag == true)
		{
			out.println("(은)는 이미 존재하는 ID입니다.<br></br>");
		} else
		{
			out.println("(은)는 사용 가능한 ID입니다.<br></br>");
	}
		%>
		<hr>
		<!-- <button onClick="javascript:self.close()">닫기</button> -->
		<a href="#" onClick="javascript:self.close()">닫기</a>
	</main>
</body>
</html>	