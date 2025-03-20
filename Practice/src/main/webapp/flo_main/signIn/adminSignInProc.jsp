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


// 관리자 - 상품 추가
	if(action.equals("ADInsert")){
        // 상품 등록이 되었다면,
		if(productDAO.insertProducts(productVO)){
			//다시 본페이지로 이동
			response.sendRedirect("control.jsp?action=list");
		}
		else{
			throw new Exception("관리자 상품추가 오류 발생!");
		}
	}
	// 관리자 - 상품 삭제
	if(action.equals("ADDelete")){
        // delete 수행(PK인 pnum으로 상품 삭제가능!)
		if(productDAO.deleteProducts(productVO)){
			//다시 본페이지로 이동
			response.sendRedirect("control.jsp?action=list");
		}
		else{ // 오류가 발생되어 delete 수행되지않았다면, errorPage이동
			throw new Exception("관리자 상품삭제 오류 발생!");
		}
	}
	// 관리자 - 상품 변경
	if(action.equals("ADUpdate")){
        // update 수행
		if(productDAO.UpdateProducts(productVO)){
			//다시 본페이지로 이동
			response.sendRedirect("control.jsp?action=list");
		}
		else{ // 오류가 발생되어 update 수행되지않았다면, errorPage이동
			throw new Exception("관리자 상품변경 오류 발생!");
		}
	}
%>