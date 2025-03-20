<%@ page import="com.flo.model.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String productIdStr = request.getParameter("productId");
    int productId = Integer.parseInt(productIdStr);
    ProductsInsertDAO dao = new ProductsInsertDAO();
    ProductsInsertVO product = new ProductsInsertVO();
    product.setProductId(productId);

    boolean success = dao.deleteProducts(product);

    if (success) {
        response.sendRedirect("productsList.jsp"); // 삭제 후 상품 목록 페이지로 이동
    } else {
        // 삭제 실패 시 alert 띄우기
        out.println("<script>");
        out.println("alert('상품 삭제에 실패했습니다.');");
        out.println("window.location.href='productsList.jsp';");
        out.println("</script>");
    }
%>
