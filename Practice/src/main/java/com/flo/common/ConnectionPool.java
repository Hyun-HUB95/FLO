package com.flo.common;

import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

// 싱글톤 처리. 따라서 new를 한 번 밖에 못함.
// (getInstance 한 번 밖에 못부름. 여기에 10번을 셋팅해놓았으니, 한 번 부름으로 10번의 실행이!)
public final class ConnectionPool
{
	// 1. Oracle Driver를 정적처리하여 로드.
	static
	{
		try
		{
			// class가 작동하는 순간.
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e)
		{
			e.printStackTrace();
		}
	}

	// 2. 멤버변수.
	private ArrayList <Connection> free;
	private ArrayList <Connection> used; // 사용중인 커넥션을 저장하는 변수
	private int initialCons = 10; // 최초로 초기 커넥션수
	private int maxCons = 20; // 최대 커넥션수
	private int numCons = 0; // 총 Connection 수
	private String id = null;
	private String pw = null;
	private String url = null;
	/*
	 * private String url = "jdbc:oracle:thin:@localhost:1521:xe"; private String
	 * user = "hr"; private String password = "hr";
	 */

	// 3. 싱글톤.
	// 자기 자신을 참조하는 private멤버변수를 하나 만든다.
	// 생성자 함수를 하나 만든다.(외부 접근하면 안되므로 private)
	// 자기 참조 멤버변수를 getters하는 getters를 하나 생성.
	private static ConnectionPool cp;

	public static ConnectionPool getInstance()
	{
		try
		{
			if (cp == null) {// null이면 만들어야 함.
								// 한 번만 실행되는 것.
				synchronized (ConnectionPool.class)
				{
					cp = new ConnectionPool();
				}
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return cp;
	}

	// 생성자(ArrayList생성, properties 로드, Connection 10개를 만들어서 free에 넣는다.
	// private이기 때문에 외부에서 부를 수 없음.
	private ConnectionPool()
	{
		// 1. 셋팅 - ArrayList를 10개까지만 사용하겠다.
		free = new ArrayList<Connection>(initialCons);
		used = new ArrayList<Connection>(initialCons);

		// 2. db.properties 파일 에서 id, pw 가져오기
		String filePath = "C:\\dev\\eclipseWorkspace\\Practice\\src\\main\\java\\com\\flo\\common\\db.properties";
		
		Properties pt = new Properties();
		try
		{
			pt.load(new FileReader(filePath));
		} catch (Exception e)
		{
			e.printStackTrace();
		}

		id = pt.getProperty("id");
		pw = pt.getProperty("pw");
		url = pt.getProperty("url");

		// 데이터베이스에 연결된 connection을 10개 만들어 free에 connection을 저장한다.
		while (numCons < initialCons)
		{ 		// 0 		10
			addConnection();
		}
	}

	// Connection을 free ArrayList에 추가하는 함수. -> 총 10번.
	private void addConnection()
	{
		free.add(getNewConnection());
	}

	// Connection을 만들어서 리턴한다.
	private Connection getNewConnection()
	{
		Connection con = null;

		try
		{
			con = DriverManager.getConnection(url, id, pw);
			numCons++;
			System.out.println("current connection count : " + numCons);
		} catch (SQLException e)
		{
			e.printStackTrace();
		}
		return con;
	}

	// dbCon을 여러 사람이 동시에 부를 수 있으니까 싱크로나이즈.
	public synchronized Connection dbCon()
	{
		// 1. free라는 ArrayList에 Connection이 들어있는지 확인. (지금 현재 10개 들어있음.)
		Connection con = null;

		if (free.isEmpty()) { // 최종 max를 20개 생성.
			while (numCons < maxCons)
			{ 		// 0	   20
				addConnection();
			}
		}
		// free의 맨 마지막 뒤에 있는 con을 가지고 옴.
		con = free.get(free.size() - 1);

		// 가져왔으니 제거.
		free.remove(con);

		used.add(con);
		// 앞으로 con은 close를 하면 안됨. release로 반납을 해줘야 함.
		return con;
	}

	public void dbClose(Connection con, ResultSet rs, Statement... stmts)
	{
		if (con != null)
		{
			releaseConnection(con);
		}
		
		for (Statement data : stmts)
		{
			if (data != null)
			{
				try
				{
					data.close();
				} catch (SQLException e)
				{
					System.out.println(e.toString());
				}
			}
		}

		if (rs != null)
		{
			try
			{
				rs.close();
			} catch (SQLException e)
			{
				System.out.println(e.toString());
			}
		}
	}

	public void dbClose(Connection con, Statement... stmts)
	{
		if (con != null)
		{
			releaseConnection(con);
		}

		for (Statement data : stmts)
		{
			if (data != null)
			{
				try
				{
					data.close();
				} catch (SQLException e)
				{
					System.out.println(e.toString());
				}
			}
		}
	}

	public void dbClose(Connection con, PreparedStatement pstmt, ResultSet rs) {
		if (con != null)
		{
			releaseConnection(con);
		}
		
		if (pstmt != null)
		{
			try
			{
				pstmt.close();
			} catch (SQLException e)
			{
				System.out.println(e.toString());
			}
		}

		if (rs != null)
		{
			try
			{
				rs.close();
			} catch (SQLException e)
			{
				System.out.println(e.toString());
			}
		}
	}

	public void dbClose(Connection con, Statement stmt, ResultSet rs)
	{
		if (con != null)
		{
			releaseConnection(con);
		}
		
		if (stmt != null)
		{
			try
			{
				stmt.close();
			} catch (SQLException e)
			{
				System.out.println(e.toString());
			}
		}

		if (rs != null)
		{
			try
			{
				rs.close();
			} catch (SQLException e)
			{
				System.out.println(e.toString());
			}
		}
	}

	// 자원 반납.
	// ConnectionPool을 만들어서 Connection free ArrayList에 반납하거나 close
	public synchronized void releaseConnection(Connection con)
	{
		boolean flag = false;

		if (used.contains(con) == true)
		{
			// uesd에서 con이 삭제됨.
			used.remove(con);

			// 10개에서 9개, 1개면 0개로 감소.
			numCons--;

			free.addLast(con);
			numCons++;

			flag = true;
		}

		try
		{
			if (flag == false)
			{ // 내가 만들어놓은 10개 안에 들어있지 않은 connection일 경우.
				con.close();
			}
		} catch (SQLException e)
		{
			e.printStackTrace();
		}
	}

	// 전체를 해제.
	public void closeAll ()
	{
		// used에 있는 커넥션을 모두 삭제해 버림.
		for (int i = 0; i < used.size(); i++)
		{
			Connection _con = (Connection) used.get(i);
			used.remove(i--);
			try
			{
				_con.close();
			} catch (SQLException sqle)
			{
				sqle.printStackTrace();
			}
		}

		// free에 있는 커넥션을 모두 삭제해 버림.
		for (int i = 0; i < free.size(); i++)
		{
			Connection _con = (Connection) free.get(i);
			free.remove(i--);
			try
			{
				_con.close();
			} catch (SQLException sqle)
			{
				sqle.printStackTrace();
			}
		}
	}
}