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
<%--<%


// [장바구니 함 이동]
if(action.equals("basket")){
    // 비회원이 장바구니함에 접속한다면 → 뒤로가기
	if(session.getAttribute("memberVO")==null){
		out.println("<script>alert('회원 이용만 가능합니다.'); history.go(-1); </script>");
		return;
	}
	pageContext.forward("basket.jsp");
}
// [장바구니 추가]
if(action.equals("basketAdd")){
    // 비회원이 장바구니 담기 버튼을 클릭시 → 뒤로가기
	if(session.getAttribute("memberVO")==null){
		out.println("<script>alert('회원 이용만 가능합니다.'); history.go(-1); </script>");
		return;
	}

	// basketList에 저장된 데이터가 없다면(== 최종생성이라면)
	if(basketList.size()==0){
		basketList = new ArrayList<ProductsVO>(); //객체화
		session.setAttribute("basketList", basketList); // session 재설정
	}

    // 사용자가 선택한 구매개수 변수에 저장
	int buyCnt = Integer.parseInt(request.getParameter("buyCnt"));
	
	// 사용자가 선택한 물품인 pnum으로 모든 데이터를 받아옴(상품명, 재고 등)
	productVO = productDAO.selectOneProducts(productVO);

/* 	// DB에 저장된 상품의 재고량이 더 적다면, 뒤로가기(==재고부족)
	if(buyCnt > productVO.getCnt()){
		out.println("<script>alert('선택제품의 재고수량이 부족하여 주문이 불가합니다.'); history.go(-1);</script>");
		return;
	}
    // 위에서 return이 되지 않았으면
    // 데이터를 받아온 객체에 → 사용자 구매개수를 set
	productVO.setCnt(buyCnt); */
	
	// 장바구니List에 → 사용자가 선택한 물품 add
	basketList.add(productVO);

    // 알림창으로 사용자 안내 후, 뒤로가기
	out.println("<script>alert('정상적으로 바구니에 담았습니다!'); history.go(-1);</script>");

}
// [장바구니 단일삭제]
if(action.equals("basketDelete")){
    // 선택한 상품의 index를 parameter로 받아 변수에 저장
	int index = Integer.parseInt(request.getParameter("index"));
    // 해당 index로 장바구니List을 remove
	basketList.remove(index);
    // 본페이지(control.jsp)에서 → 메인페이지로 이동
	response.sendRedirect("control.jsp?action=list");
}

--%>

<%@page import="com.flo.model.ProductsVO"%>
<%@page import="com.flo.model.ProductsDAO"%>
<%@page import="com.flo.model.AdminVO"%>
<%@page import="com.flo.model.CartVO"%>
<%@page import="com.flo.model.CartDAO"%>
<%@page import="java.*" %>
<%@page import="com.flo.model.AdminDAO"%>
<%@page import="com.flo.model.MemberVO"%>
<%@page import="com.flo.model.MemberDAO"%>
<%@page import="java.sql.SQLException"%>

<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="pvo" scope="page" class="com.flo.model.ProductsVO">
   <jsp:setProperty name="pvo" property="*"/>
</jsp:useBean>

<!-- 1. 사용자 정보 가져오기. -->
<!-- 2. CRUD. -->
<%
	request.setCharacterEncoding("UTF-8");

	ProductsDAO pdao = new ProductsDAO();
	
	boolean check = pdao.insertProducts(pvo);
%>

<%
    String[] selectedProducts = request.getParameterValues("product[]");
    if (selectedProducts != null) {
        CartDAO cartDAO = new CartDAO();
        String id = (String) session.getAttribute("id");

        // 로그인 체크
        if (id == null) {
%>
            <script>
                alert("로그인 후 이용해 주세요.");
                window.location.href = "signIn.jsp";  // 로그인 페이지로 리다이렉트
            </script>
<%
            return; // 이후 코드를 실행하지 않도록 합니다.
        }

        // 선택된 상품들을 장바구니에 추가
        for (String product : selectedProducts) {
            // product 값이 예상된 형식인지 확인
            String[] productDetails = product.split("\\|");

            if (productDetails.length == 3) {  // 배열이 3개 요소를 가지는지 확인
                String name = productDetails[0];
                String price = productDetails[1];
                int usePeriod = Integer.parseInt(productDetails[2]);

                // CartVO 객체 생성 후 값 설정
                CartVO cartVO = new CartVO();
                cartVO.setName(name);
                cartVO.setPrice(price);
                cartVO.setUsePeriod(usePeriod);

                // 장바구니에 추가
                boolean isAdded = cartDAO.addCart(cartVO);
                if (!isAdded) {
                    out.println("상품 추가 실패: " + name);
                }
            } else {
                out.println("잘못된 상품 데이터: " + product);
            }
        }
    } else {
%>
        <script>
            alert("상품을 선택해주세요.");
            window.location.href = "EproductsForm.jsp";  // 상품 목록 페이지로 리다이렉트
        </script>
<%
    }
%>







<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[FLO]SIGN IN</title>
</head>
<body>

</body>
</html>
<%
	if (check)
	{
%>
	<script>
		alert("이용해주셔서 감사합니다.");
		location.href ='EproductsForm.jsp';
	</script>
	
	
	<%

	}else if (pvo.getName().equals(request.getParameter("name")))
	{
		
	%>
		<script>
		alert("동일항목이 존재합니다.");
		history.go(-1);
	</script>
		
<%
	}else
	{	// 아이디 오기재시.
%>
	<script>
		alert("옵션을 모두 체크해주세요.");
		history.go(-1);
	</script>
<%
	}
%>