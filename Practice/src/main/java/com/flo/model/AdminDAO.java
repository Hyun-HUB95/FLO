package com.flo.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.flo.common.ConnectionPool;

public class AdminDAO
{
	
	private final String SELECT_SQL = "SELECT * FROM MEMBER";
	private final String SELECT_ID_SQL = "SELECT * FROM MEMBER WHERE ID = ?";
	private final String SELECT_BY_ID_SQL = "SELECT COUNT(*) AS COUNT FROM MEMBER WHERE ID = ?";
	
	private final String SELECT_LOGIN_CHECK_SQL = "SELECT PWD FROM ADMIN WHERE ID = ?";
	
	private final String INSERT_SQL = "INSERT INTO MEMBER VALUES(?,?,?,?,?,?,?,?,?,?)";
	private final String DELETE_SQL = "DELETE FROM MEMBER WHERE ID =?";
	private final String UPDATE_SQL = "UPDATE MEMBER SET PWD=?, phone1=?, phone2=?, phone3=?, email=?, zipcode=?, address1=?, address2=? WHERE id=?";
	
	public int adminLoginCheck(AdminVO avo)
	{	// to
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check = -1;
		
		String pwd = null;
		
		try
		{
			pstmt = con.prepareStatement(SELECT_LOGIN_CHECK_SQL);
			pstmt.setString(1, avo.getId());
			rs = pstmt.executeQuery();
			
			if (rs.next())
			{
				pwd = rs.getString("PWD");
				check = (pwd.equals(avo.getPwd()) == true) ? 1:0;
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		} finally
		{
			cp.dbClose(con, pstmt, rs);
		}
		return check;
	}
	
//	// regProc.
//	public Boolean insertDB(MemberVO mvo)
//		{
//			ConnectionPool cp = ConnectionPool.getInstance();
//			Connection con = cp.dbCon();
//			PreparedStatement pstmt = null;
//			
//			int count = 0;
//			
//			try
//			{
//				pstmt = con.prepareStatement(INSERT_SQL);
//				pstmt.setString(1,mvo.getId());
//				pstmt.setString(2, mvo.getPwd());
//				pstmt.setString(3, mvo.getName());
//				pstmt.setString(4, mvo.getPhone1());
//				pstmt.setString(5, mvo.getPhone2());
//				pstmt.setString(6, mvo.getPhone3());
//				pstmt.setString(7, mvo.getEmail());
//				pstmt.setString(8, mvo.getZipCode());
//				pstmt.setString(9, mvo.getAddress1());
//				pstmt.setString(10,mvo.getAddress2());
//				count = pstmt.executeUpdate();
//			} catch (SQLException e)
//			{
//				e.printStackTrace();
//			} finally
//			{
//				cp.dbClose(con, pstmt);
//			}
//			return (count > 0) ? true : false;
//		}
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
}