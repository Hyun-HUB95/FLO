<%@page import="com.flo.model.BoardDAO"%>
<%@page import="com.flo.model.BoardVO"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import = "java.sql.Timestamp" %>

<%
	request.setCharacterEncoding("UTF-8");
%>

<!-- parameter를 빈번히 사용해야 하다보니, bean을 사용. -->
<jsp:useBean id="bvo" scope="page" class="com.flo.model.BoardVO">
   <jsp:setProperty name="mvo" property="*"/>
</jsp:useBean>
<%
 bvo.setRegdate(new Timestamp(System.currentTimeMillis()));
 bvo.setIp(request.getRemoteAddr());
 BoardDAO bdao = BoardDAO.getInstance();	// 싱글톤 방식.
 boolean flag = bdao.insertDB(bvo);
 
 if (flag == true)
 {
 	response.sendRedirect("list.jsp"); 
 } else
 {
%>
	<script>
		alert("게시판 등록 실패.");
		history.go(-1);
	</script>
<%
 }
%>