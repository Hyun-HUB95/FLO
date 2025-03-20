package com.flo.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.flo.common.ConnectionPool;

// 자기 자신을 참조하는 객체 참조변수 private
// getInstance
// 
public class BoardDAO
{
	// 1. 인스턴스
	private static BoardDAO instance;
	
	// 2. 생성자
	private BoardDAO()
	{
		
	}

	// 3. getters
	public static BoardDAO getInstance ()
	{
		if (instance == null)
		// null이라는 것은 객체가 만들어지지 않은 것.
		{
			
			synchronized (BoardDAO.class)
			{
				// private더라도 자기 자신을 자신의 안에서 부르는 것은 상관 없음.
				instance = new BoardDAO();
				// null일 때 한 번만 만들고, 그 이상 만들지 않음.
			}
		}
		
		return instance;	
	}
	
//	private final String SELECT_START_END_SQL =  "select * from "
//            + "(select rownum AS rnum, num, writer, email, subject, pass, regdate, readcount, ref, step, depth, content, ip "
//            + "from (select * from board order by ref desc, step asc)) where rnum >= ? and rnum <= ?";
	
	private final String SELECT_START_END_SQL = "select * from "
			+ "(select rownum AS rnum, num, writer, email, subject, pass, regdate, readcount, ref, step, depth, content, ip "
			+ "from (select * from board order by ref desc, step asc)) where rnum >= ? and rnum <= ?";

	private final String SELECT_PASS_ID_CHECK_SQL = "select COUNT(*) AS COUNT from board where num = ? AND pass =?";
	private final String SELECT_MAX_NUM_SQL = "select max(num) as NUM from board";
	private final String SELECT_ID_SQL = "SELECT * FROM STUDENT WHERE ID = ?";
	private final String SELECT_BY_ID_SQL = "SELECT COUNT(*) AS COUNT FROM STUDENT WHERE ID = ?";
	private final String SELECT_LOGIN_CHECK_SQL = "SELECT pass FROM STUDENT WHERE ID = ?";
	// 테이블당 DAO별도로 만들어야 함.
	
	
	
	
	private final String SELECT_SQL = "select num, writer, email, subject, pass, regdate, readcount, ref, step, depth, content, ip, filename1 from board order by num desc";
    private final String SELECT_ONE_SQL = "select num, writer, email, subject, pass, regdate, readcount, ref, step, depth, content, ip, filename1 from board where num = ?";
    private final String SELECT_COUNT_SQL = "SELECT COUNT(*) AS COUNT FROM BOARD";
    private final String INSERT_SQL = "INSERT INTO board (num, writer, email, subject, pass, regdate, ref, step, depth, content, ip, filename1) "
            + "VALUES (board_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    private final String DELETE_SQL = "DELETE FROM BOARD WHERE NUM =? AND PASS = ?";
    private final String UPDATE_SQL = "update board set writer=?, email=?, subject=?, content=? where num=?";
    private final String SELECT_ZIP_SQL = "SELECT * FROM zipcode WHERE dong LIKE ?";
    private final String UPDATE_STEP_SQL = "update board set step=step+1 where ref= ? and step > ?";
    private final String UPDATE_READCOUNT_SQL = "update board set readcount=readcount+1 where num = ?";
	
    public Boolean insertDB(BoardVO bvo)
    {
        ConnectionPool cp = ConnectionPool.getInstance();
        Connection con = cp.dbCon();
        PreparedStatement pstmt = null;

        // 현재 보드속ㄱ에 가장 최고값 +1, 없으면 1로 세팅.
        ResultSet rs = null;

        int number = 0;
        int step = 0;
        int depth = 0;
        int ref = 1;
        int count = 0;

        try
        {
            pstmt = con.prepareStatement(SELECT_MAX_NUM_SQL);
            rs = pstmt.executeQuery();
            if (rs.next())
            {	// 최고값 + 1.
                number = rs.getInt("NUM") + 1;
            } else
            {	// 최고값이 없을 시, 1로 세팅.
                number = 1;
            }
        } catch (SQLException e)
        {
            e.printStackTrace();
        }

        try
        {
            if (bvo.getNum() != 0)
            {	//답변글일경우
                pstmt = con.prepareStatement(UPDATE_STEP_SQL);
                pstmt.setInt(1, bvo.getRef());
                pstmt.setInt(2, bvo.getStep());
                pstmt.executeUpdate();
                ref = bvo.getRef();
                step = bvo.getStep() + 1;
                depth = bvo.getDepth() + 1;
            } else
            {	//새 글일 경우
                ref = number;   //가장최고값 + 1
                step = 0;
                depth = 0;
            }
        } catch (SQLException e)
        {
            e.printStackTrace();
        }

        // 게시판 글 입력.
        try
        {
            pstmt = con.prepareStatement(INSERT_SQL);
            pstmt.setString(1, bvo.getWriter());
            pstmt.setString(2, bvo.getEmail());
            pstmt.setString(3, bvo.getSubject());
            pstmt.setString(4, bvo.getPass());
            pstmt.setTimestamp(5, bvo.getRegdate());
            pstmt.setInt(6, ref);
            pstmt.setInt(7, step);
            pstmt.setInt(8, depth);
            pstmt.setString(9, bvo.getContent());
            pstmt.setString(10, bvo.getIp());
            
            // filename1, filename2를 추가
            pstmt.setString(11, bvo.getFilename1());  // 첫 번째 파일 경로

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
		
		
		
//		// getNum()이 0이면 새 글, 0이 아니면 답변글.
//		if (bvo.getNum() != 0)
//		{	//답변글일경우
//			 pstmt = con.prepareStatement(UPDATE_STEP_SQL);
//			 pstmt.setInt(1, bvo.getRef());
//			 pstmt.setInt(2, bvo.getStep());
//			 pstmt.executeUpdate();
//			 step = bvo.getStep() + 1;
//			 depth = bvo.getDepth() + 1;
//			} else
//			{	//새 글일 경우
//			 ref = number;	// 최고값 + 1한 값. -> insert시 값이 정해짐.
//			 step = 0;
//			 depth = 0;
//			}// 쿼리를 작성
	
	public int selectCountDB()
	{
        ConnectionPool cp = ConnectionPool.getInstance();
        Connection con = cp.dbCon();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int count = 0;
        
        try
        {
            pstmt = con.prepareStatement(SELECT_COUNT_SQL);
            rs = pstmt.executeQuery();
            
            if(rs.next())
            {
                count = rs.getInt("COUNT");
            }
        } catch (SQLException e)
        {
            e.printStackTrace();
        } finally
        {
            cp.dbClose(con, pstmt, rs);
        }
        return count;
    }
	
	public ArrayList<BoardVO> selectDB() {
	    ConnectionPool cp = ConnectionPool.getInstance();
	    Connection con = cp.dbCon();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    ArrayList<BoardVO> boardList = new ArrayList<BoardVO>();

	    try {
	        pstmt = con.prepareStatement(SELECT_SQL);
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            int num = rs.getInt("num");
	            String writer = rs.getString("writer");
	            String email = rs.getString("email");
	            String subject = rs.getString("subject");
	            String pass = rs.getString("pass");
	            Timestamp regdate = rs.getTimestamp("regdate");
	            int readcount = rs.getInt("readcount");
	            int ref = rs.getInt("ref");
	            int step = rs.getInt("step");
	            int depth = rs.getInt("depth");
	            String content = rs.getString("content");
	            String ip = rs.getString("ip");

	            // filename1
	            String filename1 = rs.getString("filename1");

	            // BoardVO 객체에 filename1, filename2 추가
	            BoardVO bvo = new BoardVO(num, writer, email, subject, pass, readcount, ref, step, depth, regdate, content, ip, filename1);
	            boardList.add(bvo);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        cp.dbClose(con, pstmt, rs);
	    }

	    return boardList;
	}

	
	public BoardVO selectBoardDB(BoardVO bvo) {
	    ConnectionPool cp = ConnectionPool.getInstance();
	    Connection con = cp.dbCon();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    BoardVO vo = null;

	    try {
	        // 조회수 증가
	        pstmt = con.prepareStatement(UPDATE_READCOUNT_SQL);
	        pstmt.setInt(1, bvo.getNum());
	        pstmt.executeUpdate();

	        // num에 대한 전체내용
	        pstmt = con.prepareStatement(SELECT_ONE_SQL);
	        pstmt.setInt(1, bvo.getNum());
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            int num = rs.getInt("num");
	            String writer = rs.getString("writer");
	            String email = rs.getString("email");
	            String subject = rs.getString("subject");
	            String pass = rs.getString("pass");
	            Timestamp regdate = rs.getTimestamp("regdate");
	            int readcount = rs.getInt("readcount");
	            int ref = rs.getInt("ref");
	            int step = rs.getInt("step");
	            int depth = rs.getInt("depth");
	            String content = rs.getString("content");
	            String ip = rs.getString("ip");

	            // filename1
	            String filename1 = rs.getString("filename1");

	            vo = new BoardVO(num, writer, email, subject, pass, readcount, ref, step, depth, regdate, content, ip, filename1);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        cp.dbClose(con, pstmt, rs);
	    }

	    System.out.println("VO = " + vo.toString());
	    return vo;
	}

	
	public BoardVO selectBoardOneDB(BoardVO bvo)
	{
        ConnectionPool cp = ConnectionPool.getInstance();
        Connection con = cp.dbCon();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        BoardVO vo = null;
        
        int count = 0;
        
        try
        {        	
        	// num에 대한 전체내용.
            pstmt = con.prepareStatement(SELECT_ONE_SQL);
            pstmt.setInt(1, bvo.getNum());
            rs = pstmt.executeQuery();
            
            if(rs.next())
            {
            	int num = rs.getInt("num");
				String writer = rs.getString("writer");
				String email = rs.getString("email");
				String subject = rs.getString("subject");
				String pass = rs.getString("pass");
				Timestamp regdate = rs.getTimestamp("regdate");
				int readcount = rs.getInt("readcount");
				int ref = rs.getInt("ref");
				int step = rs.getInt("step");
				int depth = rs.getInt("depth");
				String content = rs.getString("content");
				String ip = rs.getString("ip");
	            String filename1 = rs.getString("filename1");
				vo = new BoardVO(num, writer, email, subject, pass, readcount, ref, step, depth, regdate, content, ip, filename1);
            }
        } catch (SQLException e)
        {
            e.printStackTrace();
        } finally
        {
            cp.dbClose(con, pstmt, rs);
        }
        System.out.println("VO = " + vo.toString());
        return vo;
    }
	
	public int updateDB(BoardVO bvo)
	{	// 1:성공, 2:pass문제, 3:수정 문제. 리턴값을 int로 할 경우.
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int passCheckCount = 0;
		int count = 0;
		
		int returnValue = 1;
		
		// pass점검.
		try {
			pstmt = con.prepareStatement(SELECT_PASS_ID_CHECK_SQL);
			pstmt.setInt(1, bvo.getNum());
			pstmt.setString(2, bvo.getPass());
			
			rs = pstmt.executeQuery();
			
			if (rs.next())
			{
				passCheckCount = rs.getInt("COUNT");
//				if (passCheckCount == 0)
//				{
//					returnValue = 2;
//				}
			}
			
		} catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		if (passCheckCount != 0)
		{	// pass가 일치하는 것.
			try
			{	// 게시판 글 입력.
				pstmt = con.prepareStatement(UPDATE_SQL);
				pstmt.setString(1, bvo.getWriter());
				pstmt.setString(2, bvo.getEmail());
				pstmt.setString(3, bvo.getSubject());
				pstmt.setString(4, bvo.getContent());
				pstmt.setInt(5, bvo.getNum());
				count = pstmt.executeUpdate();
				
				if (count == 0)
				{	// 0이라는 것은 업데이트가 잘못된 것임.
					returnValue = 3;
				} else
				{
					returnValue = 1;
				}
				
			} catch (SQLException e)
			{
				e.printStackTrace();
			} finally
			{
				cp.dbClose(con, pstmt);
			}
		} else
		{
			returnValue = 2;
		}
		return returnValue;
	}
	
	public boolean deleteDB(BoardVO bvo)
	{	// 1:성공, 2:pass문제, 3:수정 문제. 리턴값을 int로 할 경우.
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		int count = 0;

			try
			{	// 게시판 글 입력.
				pstmt = con.prepareStatement(DELETE_SQL);
				pstmt.setInt(1, bvo.getNum());
				pstmt.setString(2, bvo.getPass());
				count = pstmt.executeUpdate();
			} catch (SQLException e)
			{
				e.printStackTrace();
			} finally
			{
				cp.dbClose(con, pstmt);
			}

		return count !=0 ? true:false;
	}
	
	public ArrayList <BoardVO> selectStartEndDB(int start, int end)
	{
		ConnectionPool cp = ConnectionPool.getInstance();
		Connection con = cp.dbCon();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList<BoardVO> boardList = new ArrayList<BoardVO>(end-start+1);	// ArrayList내부 크기를 10개만 만들겠다는 것.

		try
		{
			pstmt = con.prepareStatement(SELECT_START_END_SQL);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			while (rs.next())
			{
				int num = rs.getInt("num");
				String writer = rs.getString("writer");
				String email = rs.getString("email");
				String subject = rs.getString("subject");
				String pass = rs.getString("pass");
				Timestamp regdate = rs.getTimestamp("regdate");
				int readcount = rs.getInt("readcount");
				int ref = rs.getInt("ref");
				int step = rs.getInt("step");
				int depth = rs.getInt("depth");
				String content = rs.getString("content");
				String ip = rs.getString("ip");

				BoardVO bvo = new BoardVO(num, writer, email, subject, pass, readcount, ref, step, depth, regdate, content, ip);
				boardList.add(bvo);
			}
		} catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			cp.dbClose(con, pstmt, rs);
		}
		
		return boardList;
	}
}