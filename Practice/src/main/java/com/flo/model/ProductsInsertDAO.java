package com.flo.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.flo.common.ConnectionPool;

public class ProductsInsertDAO
{
	private final String INSERT = "INSERT INTO INSERT_PRODUCTS (product_id, name, description, price, image_url, created_at, updated_at) VALUES (INSERT_PRODUCTS_SEQ.NEXTVAL, ?, ?, ?, ?, SYSDATE, SYSDATE)";
	private final String SELECT = "SELECT * FROM INSERT_PRODUCTS";
	private final String DELETE = "DELETE FROM INSERT_PRODUCTS WHERE product_id =?";
	private final String UPDATE = "UPDATE INSERT_PRODUCTS SET product_id=?, name=?, description=?, price=?, image_url=?, created_at=?, updated_at=SYSDATE WHERE product_id=?";
	
	// 관리자 상품 등록. - only admin.
	public Boolean insertProducts(ProductsInsertVO pivo)
	{
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		
		int count = 0;
		
		try
		{
			pstmt = con.prepareStatement(INSERT);
	        pstmt.setString(1, pivo.getName());          // 상품명
	        pstmt.setString(2, pivo.getDescription());   // 상품 설명
	        pstmt.setDouble(3, pivo.getPrice());         // 가격
	        pstmt.setString(4, pivo.getImageUrl());      // 이미지 URL
	        count = pstmt.executeUpdate();
		} catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			cp.dbClose(con, pstmt);
		}
		return (count > 0) ? true : false;
	}
	
	// 등록된 상품 출력.
	public ArrayList <ProductsInsertVO> selectProducts()
	{
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;

		ResultSet rs = null;

		ArrayList<ProductsInsertVO> productsInsertList = new ArrayList<ProductsInsertVO>();

		try
		{
			pstmt = con.prepareStatement(SELECT);
			rs = pstmt.executeQuery();
			
			while (rs.next())
			{
				int productId = rs.getInt("product_id");	// 상품 고유 ID (Primary Key)
				String name = rs.getString("name");	// 상품명
				String description = rs.getString("description");	// 상품 설명
				double price = rs.getDouble("price");	// 가격
				String imageUrl = rs.getString("image_url");	// 이미지 저장 경로
				Timestamp createdAt = rs.getTimestamp("created_at");	// 상품 등록일
				Timestamp updatedAt = rs.getTimestamp("updated_at");	// 상품 수정일
				
				ProductsInsertVO pivo = new ProductsInsertVO(productId, name, description, price, imageUrl, createdAt, updatedAt);
				productsInsertList.add(pivo);
			}
		} catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			cp.dbClose(con, pstmt, rs);
		}
		
		return productsInsertList;
	}
	
	
	// 등록 상품 삭제. - only admin.
	// 삭제된 상품이 없을 경우 예외 처리나 로깅 추가 가능
	public boolean deleteProducts(ProductsInsertVO pivo)
	{
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		int count = 0;

		try
		{
			pstmt = con.prepareStatement(DELETE);
			pstmt.setInt(1, pivo.getProductId());
			count = pstmt.executeUpdate();
			if (count == 0)
			{
				System.out.println("상품 삭제 실패 - 해당 상품이 존재하지 않음.");
				return false;
			}
		} catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			cp.dbClose(con, pstmt);
		}

		return count > 0;
	}
	
	public int updateProducts(ProductsInsertVO pivo)
	{
	    ConnectionPool cp = ConnectionPool.getInstance();
	    Connection con = cp.dbCon();
	    PreparedStatement pstmt = null;

	    int count = 0;
	    int returnValue = 1;

	    try
	    {
	        pstmt = con.prepareStatement(UPDATE);
	        pstmt.setInt(1, pivo.getProductId());  // 상품 ID
	        pstmt.setString(2, pivo.getName());     // 상품명
	        pstmt.setString(3, pivo.getDescription());  // 상품 설명
	        pstmt.setDouble(4, pivo.getPrice());    // 가격
	        pstmt.setString(5, pivo.getImageUrl());  // 이미지 URL
	        pstmt.setTimestamp(6, pivo.getCreatedAt());  // createdAt은 수정하지 않음
	        // updatedAt은 SYSDATE로 자동 갱신됨

	        count = pstmt.executeUpdate();

	        if (count == 0)
	        {
	            returnValue = 3;  // 업데이트 실패
	        }
	        else
	        {
	            returnValue = 1;  // 정상 처리
	        }

	    } catch (SQLException e)
	    {
	        e.printStackTrace();
	    } finally
	    {
	        cp.dbClose(con, pstmt);
	    }

	    return returnValue;
	}
	
	public ProductsInsertVO selectProductById(int productId) {
	    ConnectionPool cp = ConnectionPool.getInstance();
	    Connection con = cp.dbCon();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    ProductsInsertVO product = null;

	    try {
	        String query = "SELECT * FROM INSERT_PRODUCTS WHERE product_id = ?";
	        pstmt = con.prepareStatement(query);
	        pstmt.setInt(1, productId);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            String name = rs.getString("name");
	            String description = rs.getString("description");
	            double price = rs.getDouble("price");
	            String imageUrl = rs.getString("image_url");
	            Timestamp createdAt = rs.getTimestamp("created_at");
	            Timestamp updatedAt = rs.getTimestamp("updated_at");

	            product = new ProductsInsertVO(productId, name, description, price, imageUrl, createdAt, updatedAt);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        cp.dbClose(con, pstmt, rs);
	    }

	    return product;
	}

}