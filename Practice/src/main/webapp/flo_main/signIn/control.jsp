<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.ArrayList, com.flo.model.*"
	errorPage="errorPage.jsp"%>
	<!-- 빈즈 클래스 -->
<jsp:useBean id="memberDAO" class="com.flo.model.MemberDAO"/>
<jsp:useBean id="productDAO" class="com.flo.model.ProductsDAO"/>
<jsp:useBean id="basketList" class="java.util.ArrayList" scope="session"/>

<jsp:useBean id="memberVO" class="com.flo.model.MemberVO"/>
<jsp:useBean id="productVO" class="com.flo.model.ProductsVO"/>

<jsp:setProperty property="*" name="memberVO"/>
<jsp:setProperty property="*" name="productVO"/>
	
	
	
<%  // 다국어 처리
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>

<%     
//  변수 저장 = 사용자 요청목적
	String action = request.getParameter("action");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>



</body>
</html>