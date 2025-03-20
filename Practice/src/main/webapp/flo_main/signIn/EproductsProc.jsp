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
<jsp:useBean id="MemberDAO" class="com.flo.model.MemberDAO" />
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