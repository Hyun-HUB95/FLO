package com.flo.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.flo.common.ConnectionPool;

public class ProductsDAO
{
	private final String SELECT_SQL = "SELECT * FROM PRODUCTS";
	private final String SELECT_ONE_SQL = "SELECT * FROM PRODUCTS WHERE NAME=?";
	
	private final String SELECT_ID_SQL = "SELECT * FROM MEMBER WHERE ID = ?";
	private final String SELECT_BY_ID_SQL = "SELECT COUNT(*) AS COUNT FROM MEMBER WHERE ID = ?";
	
	private final String SELECT_LOGIN_CHECK_SQL = "SELECT PWD FROM ADMIN WHERE ID = ?";
	
	private final String INSERT_SQL = "INSERT INTO PRODUCTS VALUES(PRODUCTS_SEQ.NEXTVAL, ?, ?, ?)";	
	private final String DELETE_SQL = "DELETE FROM PRODUCTS WHERE NO=?";
	private final String UPDATE_SQL = "UPDATE PRODUCTS SET PRICE=?, USE_PERIOD=? WHERE NAME=?";
	
//	public int adminLoginCheck(AdminVO avo)
//	{	// to
//		ConnectionPool cp = ConnectionPool.getInstance();
//		Connection con = cp.dbCon();
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		int check = -1;
//		
//		String pwd = null;
//		
//		try
//		{
//			pstmt = con.prepareStatement(SELECT_LOGIN_CHECK_SQL);
//			pstmt.setString(1, avo.getId());
//			rs = pstmt.executeQuery();
//			
//			if (rs.next())
//			{
//				pwd = rs.getString("PWD");
//				check = (pwd.equals(avo.getPwd()) == true) ? 1:0;
//			}
//		} catch (Exception e)
//		{
//			e.printStackTrace();
//		} finally
//		{
//			cp.dbClose(con, pstmt, rs);
//		}
//		return check;
//	}
	
	// productsProc.
	public Boolean insertProducts(ProductsVO pvo)
		{
			ConnectionPool cp = ConnectionPool.getInstance();
			Connection con = cp.dbCon();
			PreparedStatement pstmt = null;
			
			int count = 0;
			
			try
			{
				pstmt = con.prepareStatement(INSERT_SQL);
				pstmt.setString(1, pvo.getName());	// NAME
				pstmt.setString(2, pvo.getPrice());	// PRICE
				pstmt.setInt(3, pvo.getUsePeriod());	// PERIOD
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
	
	// [전체 상품 조회.]
	public ArrayList <ProductsVO> selectAllProducts ()
	{
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList <ProductsVO> pList = new ArrayList<ProductsVO>(); // 리스트 인스턴스화
		
		try
		{
			pstmt = con.prepareStatement(SELECT_SQL);
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{ // 데이터가 n개 이상이므로 반복문으로 데이터를 받아옴
				int no = rs.getInt("NO");
				String name = rs.getString("NAME");
				String price = rs.getString("PRICE");
				int usePeriod = rs.getInt("USE_PERIOD");
				
				ProductsVO pvo = new ProductsVO(no, name, price, usePeriod);
				pList.add(pvo);
			}
			rs.close(); // close
		} catch (SQLException e)
	    {
			e.printStackTrace();
		}finally
	    {
			cp.dbClose(con, pstmt, rs); // DB접근 객체 close
		}
		return pList; // 저장된 데이터 목록을 리턴
	}
	
	
	// [단일 상품 조회.]
	public ProductsVO selectOneProducts(ProductsVO pvo)
	{
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ProductsVO pList = null;
		
		try
		{
			pstmt = con.prepareStatement(SELECT_ONE_SQL);
			pstmt.setString(1, pvo.getName());
			rs = pstmt.executeQuery();
			if (rs.next())
			{ // 반환받은 rs에 데이터가 있다면 조건문 수행
				pList.setNo(rs.getInt("NO")); // select한 DB데이터를 → 객체에 set
				pList.setName(rs.getString("NAME")); // ""
				pList.setPrice(rs.getString("PRICE")); // ""
				pList.setUsePeriod(rs.getInt("USE_PERIOD")); // ""
			}
			rs.close(); // close
		} catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			cp.dbClose(con, pstmt, rs); // DB접근 객체 close
		}

		return pvo; // data반환 ( 이때, 위 조건문이 실행되지 않았다면 null로 반환된다. )
	}
	
	// [상품 업데이트.]
	public boolean UpdateProducts(ProductsVO pvo)
	{
		
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;

		try
		{
			pstmt = con.prepareStatement(UPDATE_SQL);
			pstmt.setString(1, pvo.getPrice()); // 관리자 업뎃 정보 - PNAME삽입
			pstmt.setInt(2, pvo.getUsePeriod()); // 관리자 업뎃 정보 - PRICE삽입
			pstmt.setString(3, pvo.getName()); // 관리자 업뎃 정보 - CNT 삽입
			pstmt.executeUpdate();  // Query문 업데이트
				
		} catch (SQLException e)
		{
			e.printStackTrace();
			return false; // 오류가 발생했다면 false반환
		} finally
		{
			cp.dbClose(con, pstmt); // DB접근 객체 close
		}
			
			return true; // 정상적으로 등록이 되었다면 true 반환
	}
	
		// [상품 삭제.]
		public boolean deleteProducts (ProductsVO pvo)
		{
			ConnectionPool cp = ConnectionPool.getInstance();
			Connection con = cp.dbCon();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try
			{
				pstmt = con.prepareStatement(DELETE_SQL);
				pstmt.setInt(1, pvo.getNo()); // PK인 PNUM을 통해 상품삭제 진행
				pstmt.executeUpdate();  // Query문 업데이트
			} catch (SQLException e)
			{
				e.printStackTrace();
				return false; // 오류가 발생했다면 false반환
			} finally
			{
				cp.dbClose(con, pstmt); // DB접근 객체 close
			}
			return true; // 정상적으로 등록이 되었다면 true 반환
		}
	}
	
	
//		
//	// idCheck.
//	public boolean selectIdCheck(MemberVO mvo)
//		{
//			ConnectionPool cp = ConnectionPool.getInstance();
//			Connection con = cp.dbCon();
//			PreparedStatement pstmt = null;
//			ResultSet rs = null;
//			int count = 0;
//
//			try
//			{
//				pstmt = con.prepareStatement(SELECT_BY_ID_SQL);
//				pstmt.setString(1, mvo.getId());
//				rs = pstmt.executeQuery();
//
//				if (rs.next())
//				{
//					count = rs.getInt("count");
//				}
//			} catch (SQLException e)
//			{
//				e.printStackTrace();
//			} finally
//			{
//				cp.dbClose(con, pstmt, rs);
//			}
//
//			return (count != 0) ? true : false;
//		}
//
//	// modifyProc.
//	public MemberVO getMember(String id)
//	{
//		ConnectionPool cp = ConnectionPool.getInstance();
//		Connection con = cp.dbCon();
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		
//		MemberVO mvo = null;
//
//		try
//		{
//			pstmt = con.prepareStatement(SELECT_ID_SQL);
//			pstmt.setString(1, id);
//			rs = pstmt.executeQuery();
//			
//			if (rs.next())
//			{	// 해당 아이디에 대한 회원이 존재
//				mvo = new MemberVO();
//				mvo.setId(rs.getString("id"));
//				mvo.setPwd(rs.getString("pwd"));
//				mvo.setName(rs.getString("name"));
//				mvo.setPhone1(rs.getString("phone1"));
//				mvo.setPhone2(rs.getString("phone2"));
//				mvo.setPhone3(rs.getString("phone3"));
//				mvo.setEmail(rs.getString("email"));
//				mvo.setZipCode(rs.getString("zipCode"));
//				mvo.setAddress1(rs.getString("Address1"));
//				mvo.setAddress2(rs.getString("Address2"));
//			}
//		} catch (Exception e)
//		{
//			e.printStackTrace();
//		} finally
//		{
//			if (rs != null)
//			{
//				try
//				{
//					rs.close();
//				} catch (SQLException e)
//				{
//					e.printStackTrace();
//				}
//			}
//				
//			if (pstmt != null)
//			{
//				try
//				{
//					pstmt.close();
//				} catch (SQLException e)
//				{
//					e.printStackTrace();
//				}
//			}
//				
//			if (con != null)
//			{
//				try
//				{
//					con.close();
//				} catch (SQLException e)
//				{
//					e.printStackTrace();
//				}
//			}
//		}
//			
//		return mvo;
//	}
//
//	// modifyProc.
//	public void updateMember(MemberVO mvo)
//	{
//		ConnectionPool cp = ConnectionPool.getInstance();
//		Connection con = cp.dbCon();
//		PreparedStatement pstmt = null;
//		 
//		try
//		{
//			pstmt = con.prepareStatement(UPDATE_SQL);
//			pstmt.setString(1, mvo.getPwd());
//			pstmt.setString(2, mvo.getPhone1());
//			pstmt.setString(3, mvo.getPhone2());
//			pstmt.setString(4, mvo.getPhone3());
//			pstmt.setString(5, mvo.getEmail());
//			pstmt.setString(6, mvo.getZipCode());
//			pstmt.setString(7, mvo.getAddress1());
//			pstmt.setString(8, mvo.getAddress2());
//			pstmt.setString(9, mvo.getId());
//			pstmt.executeUpdate();
//		 } catch (Exception e)
//		 {
//			e.printStackTrace();
//		 } finally
//		 {
//			if (pstmt != null)
//			{
//				try
//				{
//					pstmt.close();
//				} catch (SQLException e)
//				{
//					e.printStackTrace();
//				}
//			}
//			
//			if (con != null)
//			{
//				try
//				{
//					con.close();
//				} catch (SQLException e)
//				{
//					e.printStackTrace();
//				}
//			}
//		 }
//	}
//	
//	// deleteProc.
//		public int deleteMember(String id, String pass)
//		{
//			ConnectionPool cp = ConnectionPool.getInstance();
//			Connection con = cp.dbCon();
//			PreparedStatement pstmt = null;
//			ResultSet rs = null;
//			
//			String dbPass = "";	// 데이터베이스에 실제 저장된 패스워드
//			
//			int result = -1;	// 결과치
//			
//			try
//			{
//				pstmt = con.prepareStatement(SELECT_LOGIN_CHECK_SQL);
//				pstmt.setString(1, id);
//				rs = pstmt.executeQuery();
//				
//				if (rs.next())
//				{
//					dbPass = rs.getString("pwd");
//					if (dbPass.equals(pass))
//					{	// true - 본인 확인
//						pstmt = con.prepareStatement(DELETE_SQL);
//						pstmt.setString(1, id);
//						pstmt.executeUpdate();
//						result = 1;// 회원탈퇴 성공
//					} else
//					{	// 본인확인 실패 - 비밀번호 오류
//						result = 0;
//					}
//				}
//			} catch (Exception e)
//			{
//				e.printStackTrace();
//			} finally
//			{
//				if (rs != null)
//				{
//					try
//					{
//						rs.close();
//					} catch (SQLException e)
//					{
//						e.printStackTrace();
//					}
//				}
//				
//				if (pstmt != null)
//				{
//					try
//					{
//						pstmt.close();
//					} catch (SQLException e)
//					{
//						e.printStackTrace();
//					}
//				}
//				
//				if (con != null)
//				{
//					{
//						try
//						{
//							con.close();
//						} catch (SQLException e)
//						{
//							e.printStackTrace();
//						}
//					}
//				}
//			}
//			
//			return result;
//		}