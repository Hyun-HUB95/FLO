package com.flo.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.flo.common.ConnectionPool;

public class ZipCodeDAO
{
		private final String SELECT_ZIP_SQL = "SELECT * FROM ZIPCODE WHERE DONG LIKE ?";
	
		// zipCheck.
		public ArrayList <ZipCodeVO> selectZipCode(ZipCodeVO zvo)
		{
			ConnectionPool cp = ConnectionPool.getInstance();
			Connection con = cp.dbCon();
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			ArrayList<ZipCodeVO> zipList = new ArrayList<ZipCodeVO>();

			try
			{
				pstmt = con.prepareStatement(SELECT_ZIP_SQL);
				String dongValue = zvo.getDong() + "%"; // "박촌동%"
				pstmt.setString(1, dongValue);
				rs = pstmt.executeQuery();

				while (rs.next())
				{
					String zipcode = rs.getString("zipcode");
					String sido = rs.getString("sido");
					String gugun = rs.getString("gugun");
					String dong = rs.getString("dong");
					String bunji = rs.getString("bunji");

					ZipCodeVO obj = new ZipCodeVO(zipcode, sido, gugun, dong, bunji);

					zipList.add(obj);
				}
			} catch (SQLException e)
			{
				e.printStackTrace();
			} finally
			{
				cp.dbClose(con, pstmt, rs);
			}
			
			return zipList;
		}
}