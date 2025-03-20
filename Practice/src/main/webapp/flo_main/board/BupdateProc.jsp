<%@page import="com.flo.model.BoardDAO"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.sql.Timestamp"%>

<%
	request.setCharacterEncoding("UTF-8");
	String pageNum = request.getParameter("pageNum");
%>
	<jsp:useBean id="bvo" scope="page" class="com.flo.model.BoardVO">
		<jsp:setProperty name="bvo" property="*" />
	</jsp:useBean>
<%
	BoardDAO bdao = BoardDAO.getInstance();
	int check = bdao.updateDB(bvo);
	if (check == 1)
	{
%>
	<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=pageNum%>">
<%
	} else if (check == 2)
	{
%>
	<script language="JavaScript">
		alert("비밀번호가 일치하지 않습니다.");
		history.go(-1);
	</script>
<%
	} else
	{
%>
	<script language="JavaScript">
		alert("업데이트에 문제가 발생하였습니다.");
		history.go(-1);
	</script>
<%
	}
%>