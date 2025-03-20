package com.flo.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.flo.common.ConnectionPool;

public class CartDAO {

    private final String SELECT_ALL_CART_SQL = "SELECT * FROM CART";
    private final String checkProductQuery = "SELECT COUNT(*) FROM PRODUCTS WHERE NAME = ?";

    // [전체 장바구니 조회.]
    public ArrayList<CartVO> selectAllCart() {
        ConnectionPool cp = ConnectionPool.getInstance();
        Connection con = cp.dbCon();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        ArrayList<CartVO> cartList = new ArrayList<CartVO>(); // 리스트 인스턴스화

        try {
            pstmt = con.prepareStatement(SELECT_ALL_CART_SQL);
            rs = pstmt.executeQuery();

            while (rs.next()) { // 데이터가 n개 이상이므로 반복문으로 데이터를 받아옴
                int no = rs.getInt("NO");
                String name = rs.getString("NAME");
                String price = rs.getString("PRICE");
                int usePeriod = rs.getInt("USE_PERIOD");
                int totalPrice = rs.getInt("TOTAL_PRICE");

                // CartVO 객체 생성하여 데이터를 넣고 리스트에 추가
                CartVO cartVO = new CartVO();
                cartVO.setNo(no);
                cartVO.setName(name);
                cartVO.setPrice(price);
                cartVO.setUsePeriod(usePeriod);
                cartVO.setTotalPrice(totalPrice);

                cartList.add(cartVO); // 리스트에 CartVO 객체 추가
            }
            rs.close(); // ResultSet close
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            cp.dbClose(con, pstmt, rs); // DB 접근 객체 close
        }
        return cartList; // 저장된 장바구니 데이터 목록을 리턴
    }
    
    public boolean addCart(CartVO cartVO) throws SQLException {
        ConnectionPool cp = ConnectionPool.getInstance();
        Connection con = cp.dbCon();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // 트랜잭션을 수동으로 처리
            con.setAutoCommit(false);  // 자동 커밋 비활성화

            // PRODUCTS 테이블에 해당 상품이 존재하는지 확인
            pstmt = con.prepareStatement(checkProductQuery);
            pstmt.setString(1, cartVO.getName());
            rs = pstmt.executeQuery();

            // 상품이 존재하면 CART 테이블에 데이터 삽입
            if (rs.next() && rs.getInt(1) > 0) {
                String insertQuery = "INSERT INTO CART (NO, NAME, PRICE, USE_PERIOD, TOTAL_PRICE) VALUES (CART_SEQ.NEXTVAL, ?, ?, ?)";
                try (PreparedStatement insertPstmt = con.prepareStatement(insertQuery)) {
                    insertPstmt.setString(1, cartVO.getName());
                    insertPstmt.setString(2, cartVO.getPrice());
                    insertPstmt.setInt(3, cartVO.getUsePeriod());
                    int rowsAffected = insertPstmt.executeUpdate();
                    
                    // 삽입된 행 수가 0이면 문제 발생
                    if (rowsAffected == 0) {
                        con.rollback();  // 삽입 실패 시 롤백
                        throw new SQLException("장바구니 추가에 실패했습니다.");
                    }
                    
                    con.commit();  // 삽입 성공 시 커밋
                    return true;
                }
            } else {
                con.rollback();  // 부모 테이블에 해당 상품이 없으면 롤백
                throw new SQLException("부모 테이블에 해당 상품이 존재하지 않습니다.");
            }
        } catch (SQLException e) {
            e.printStackTrace();  // 예외를 로그로 기록
            if (con != null) {
                try {
                    con.rollback();  // 예외 발생 시 롤백
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw e;  // 예외를 호출한 곳으로 던짐
        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true);  // 자동 커밋을 다시 활성화
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            cp.dbClose(con, pstmt, rs);  // 연결 자원 해제
        }
    }

}
