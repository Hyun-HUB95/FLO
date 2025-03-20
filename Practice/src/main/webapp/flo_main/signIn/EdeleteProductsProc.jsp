<%@page import="com.flo.model.AdminVO"%>
<%@page import="com.flo.model.AdminDAO"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="MemberDAO" class="com.flo.model.MemberDAO" />

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.ArrayList,com.flo.model.*"
	errorPage="errorPage.jsp"%>
	
<%  // 다국어 처리
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	
	ProductsDAO pdao = new ProductsDAO();
	ProductsVO pvo = new ProductsVO();
	boolean flag = pdao.deleteProducts(pvo);
%>
<!-- 빈즈 클래스 -->
<jsp:useBean id="memberDAO" class="com.flo.model.MemberDAO"/>
<jsp:useBean id="productDAO" class="com.flo.model.ProductsDAO"/>
<jsp:useBean id="basketList" class="java.util.ArrayList" scope="session"/>

<jsp:useBean id="memberVO" class="com.flo.model.MemberVO"/>
<jsp:useBean id="productVO" class="com.flo.model.ProductsVO"/>

<jsp:setProperty property="*" name="memberVO"/>
<jsp:setProperty property="*" name="productVO"/>

<%     
//  변수 저장 = 사용자 요청목적
	String action = request.getParameter("action");
%>

<!-- 1. 사용자 정보 가져오기. -->
<!-- 2. CRUD. -->
<%
    // 비회원이 장바구니함에 접속한다면 → 뒤로가기
	if(session.getAttribute("id")==null)
	{
		out.println("<script>alert('로그인 후 이용해주세요.'); history.go(-1); </script>");
		return;
	} else
	{
		
	}
	// pageContext.forward("productsCart.jsp");
	

%>