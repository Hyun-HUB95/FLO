<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="com.flo.model.ProductsInsertDAO, com.flo.model.ProductsInsertVO" %>
<%@ page errorPage="errorPage.jsp" %>

<%
    String errorMsg = "";
    try {
        // 상품 ID 받기
        int productId = 0;
        String productIdStr = request.getParameter("productId");

        if (productIdStr != null && !productIdStr.isEmpty()) {
            try {
                productId = Integer.parseInt(productIdStr);
            } catch (NumberFormatException e) {
                errorMsg = "상품 ID가 유효하지 않습니다.";
                throw new Exception(errorMsg);
            }
        } else {
            errorMsg = "상품 ID가 유효하지 않습니다.";
            throw new Exception(errorMsg);
        }

        // 상품 조회
        ProductsInsertDAO dao = new ProductsInsertDAO();
        ProductsInsertVO product = dao.selectProductById(productId);

        if (product == null) {
            errorMsg = "상품을 찾을 수 없습니다.";
            throw new Exception(errorMsg);
        }

        // 파라미터로 받은 상품 정보 수정
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        String newImageFileName = null;

        // 이미지 파일 처리
        Part newImagePart = request.getPart("newImage");
        if (newImagePart != null && newImagePart.getSize() > 0) {
            String fileName = Paths.get(newImagePart.getSubmittedFileName()).getFileName().toString();
            newImageFileName = "uploads/" + fileName;
            newImagePart.write(getServletContext().getRealPath("/") + newImageFileName);
        }

        // 상품 수정
        product.setName(name);
        product.setDescription(description);
        product.setPrice(price);
        if (newImageFileName != null) {
            product.setImageUrl(newImageFileName);
        }

        boolean updateResult = dao.updateProducts(product) > 0;
        if (updateResult) {
            response.sendRedirect("productsList.jsp");  // 수정 후 상품 목록으로 리디렉션
        } else {
            errorMsg = "상품 수정에 실패했습니다.";
        }
    } catch (Exception e) {
        errorMsg = "오류 발생: " + e.getMessage();
    }

    if (!errorMsg.isEmpty()) {
        out.println("<script>alert('" + errorMsg + "'); history.back();</script>");
    }
%>
