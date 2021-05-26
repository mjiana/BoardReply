package board;

import java.sql.*;
import java.util.*;
import mydb.poolfact.*;

public class BoardQuery {
	String board = "boardRe"; //table name
	String idxNum = "boardRe_idx_seq.nextval"; //sequence
	ConnectionPool pool = null; 

	//��ü�� ������ �� ����
	public BoardQuery() {
		try {
			pool = ConnectionPool.getInstance();
		} catch (Exception e) {
			System.out.println("������� "+ e);
		}
	}//BoardQury() end
	
	//���ڿ��� Ư����ȣ(< > & " )�Է� �� ��ȯ 
	public String StrReplace(String str) {
		str = str.replaceAll("<", "&lt;");  //����Ͻ�����
		str = str.replaceAll(">", "&gt;");
		//str = str.replaceAll("&", "&amp;"); //����ϸ� ���� < > ��ȣ�� ������.
		str = str.replaceAll("\"", "&quot;");
		return str;
	}
	
	//�۾��� DB����
	public boolean boardInsert(BoardBean bb) throws SQLException{
		boolean result = false;
		Connection conn = pool.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		int n_step, n_ref, n_depth = 0;
		
		try {
			sql = "select max(idx) from "+board;
			pstmt = conn.prepareStatement(sql); 
			rs = pstmt.executeQuery();
			
			//�׷��ȣ
			int max_ref = 0;
			if(rs.next()) max_ref = rs.getInt(1)+1;
			else max_ref = 1; 
			pstmt.close();
			//�� ���� ���
			if(bb.getIdx() == 0) {
				n_step = 0;
				n_ref = max_ref;
				n_depth = 0;
			}else { //����� ��� �߰��� �Էµ� �� �ֵ��� �ڸ� ����
				sql = "update "+board+" set step=step+1"+
						" where ref = ? and step > ?";
				pstmt = conn.prepareStatement(sql); 
				pstmt.setInt(1, bb.getRef());
				pstmt.setInt(2, bb.getStep()); 
				
				n_step = bb.getStep()+1;
				n_ref = bb.getRef();
				n_depth = bb.getDepth()+1;
				
				pstmt.executeQuery();
			}
			
			sql = "insert into "+board+" values("+idxNum+",?,?,?,?,?,?,sysdate,?,?,?,0)"; 
			pstmt = conn.prepareStatement(sql); 
			
			pstmt.setString(1, StrReplace(bb.getName()));
			pstmt.setString(2, StrReplace(bb.getEmail())); 
			pstmt.setString(3, StrReplace(bb.getHomepage())); 
			pstmt.setString(4, StrReplace(bb.getTitle()));
			pstmt.setString(5, StrReplace(bb.getContent())); 
			pstmt.setString(6, bb.getPwd());
			pstmt.setInt(7, n_step); 
			pstmt.setInt(8, n_ref);
			pstmt.setInt(9, n_depth);
			
			int cnt = pstmt.executeUpdate();
			if(cnt == 1) result = true;
			else result = false;		
		} catch (Exception e) {
			System.out.println("boardInsert Exception : "+e);
		} finally {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			pool.releseConnection(conn);
		}
		return result;
	} //boardInsert end
	
	//�Խñ��� �Ѱ��� ���ϱ�
	public int boardCount() throws SQLException{
		int cnt = 0;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			conn = pool.getConnection();
			stmt = conn.createStatement();
			sql = "select count(*) from "+board;
			rs = stmt.executeQuery(sql);
			rs.next();
			cnt = rs.getInt(1); //�÷����� count�Լ��̹Ƿ� ���ڷ� �÷� �޾ƿ���
			
		} catch (Exception e) {
			System.out.println("boardCount Exception : "+e);
		} finally {
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			pool.releseConnection(conn);
		}
		return cnt;
	} //boardCount() end
	
	//�Խ��� ��� ��������
	public Vector getBoardList(int offset, int limit) throws SQLException{
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector boardList = new Vector();
		try {
			conn = pool.getConnection();
			stmt = conn.createStatement();
			sql = "select a.* from ( select ROWNUM as RN, b.* from "
						+"(select * from "+board+" order by ref desc, step asc)b"
					+")a where a.RN > "+offset+" and a.RN <= "+(offset+limit);
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setIdx(rs.getInt("idx"));
				bb.setHit(rs.getInt("hit"));
				bb.setName(rs.getString("name"));
				bb.setEmail(rs.getString("email"));
				bb.setHomepage(rs.getString("homepage"));
				bb.setTitle(rs.getString("title"));
				bb.setWdate(rs.getString("wdate").substring(0,10));
				bb.setRef(rs.getInt("ref"));
				bb.setDepth(rs.getInt("depth"));
				boardList.add(bb);
			}//while
		} catch (Exception e) {
			System.out.println("getBoardList Exception : "+e);
		} finally {
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			pool.releseConnection(conn);
		}
		return boardList;
	}//getBoardList(int offset, int limit) end

	//�Խñ� ��ȸ�� ����
	public void boardHitUp(int idx) throws SQLException{
		Connection conn = null;
		Statement stmt = null;
		try {
			 conn = pool.getConnection();
			 stmt = conn.createStatement();
			String sql = "update "+board+" set hit=hit+1 where idx="+idx;
			stmt.executeUpdate(sql); 
		}catch (Exception e) {
			System.out.println("boardHitUp Exception : "+e);
		} finally {
			if(stmt != null) stmt.close();
			pool.releseConnection(conn);
		}
	}//boardHitUp end
	
	//�Խñ� ����
	public BoardBean boardView(int idx) throws SQLException{
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		BoardBean bb = null;
		try {
			conn = pool.getConnection();
			stmt = conn.createStatement();
			String sql = "select * from "+board+" where idx="+idx;
			rs = stmt.executeQuery(sql);
			bb = new BoardBean();
			if(rs.next()) {
				bb.setIdx(rs.getInt("idx"));
				bb.setHit(rs.getInt("hit"));
				bb.setName(rs.getString("name"));
				bb.setEmail(rs.getString("email"));
				bb.setHomepage(rs.getString("homepage"));
				bb.setTitle(rs.getString("title"));
				String content = rs.getString("content");
				content = content.replaceAll("\n", "<br>");
				bb.setContent(content);
				bb.setWdate(rs.getString("wdate"));
				bb.setStep(rs.getInt("step"));
				bb.setRef(rs.getInt("ref"));
				bb.setDepth(rs.getInt("depth"));
				bb.setHit(rs.getInt("hit"));
			}//if end
		}catch (Exception e) {
			System.out.println("boardView Exception : "+e);
		} finally {
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			pool.releseConnection(conn);
		}
		return bb;
	}// boardView end
	
	//��й�ȣ üũ
	public boolean passwordCheck(int idx, String pwd) throws SQLException{
		boolean chk = false;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = pool.getConnection();
			stmt = conn.createStatement();
			String sql = "select pwd from "+board+" where idx="+idx;
			rs = stmt.executeQuery(sql);
			rs.next();
			
			String pwd2 = rs.getString("pwd");
			pwd = pwd.trim(); //������ �Ѿ�� �� �յ� ��������
			pwd2 = pwd2.trim(); //DB���� ������ ��ȣ�� �յ� ��������
			if(pwd.equals(pwd2)) chk = true;
		}catch (Exception e) {
			System.out.println("passwordCheck Exception : "+e);
		} finally {
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			pool.releseConnection(conn);
		}
		return chk;
	}//passwordCheck end
	
	//�� ����
	public boolean boardUpdate(BoardBean bb) throws SQLException {
		boolean result = false;
		Connection conn = pool.getConnection();
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			 if(passwordCheck(bb.getIdx(),bb.getPwd())) {
				sql = "update "+board+" set name=?, email=?, homepage=?, title=?, content=? where idx=?";
				pstmt = conn.prepareStatement(sql); 
				pstmt.setString(1, StrReplace( bb.getName()));
				pstmt.setString(2, StrReplace(bb.getEmail())); 
				pstmt.setString(3, StrReplace(bb.getHomepage())); 
				pstmt.setString(4, StrReplace(bb.getTitle()));
				pstmt.setString(5, StrReplace(bb.getContent())); 
				pstmt.setInt(6, bb.getIdx()); 
				
				int cnt = pstmt.executeUpdate();
				if(cnt == 1) result = true;
				else result = false;
			 }else {
				 result = false;
			 }
		}catch (Exception e) {
			System.out.println("boardUpdate Exception : "+e);
		} finally {
			if(pstmt != null) pstmt.close();
			pool.releseConnection(conn);
		}
		return result;
	}//boardUpdate end
	
	//�� ����
	public boolean boardDelete(int idx, String pwd) throws SQLException {
		boolean result = false;
		Connection conn = pool.getConnection();
		Statement stmt = conn.createStatement();
		String sql = "";
		try {
			if(passwordCheck(idx,pwd)) {
				sql = "delete from "+board+" where idx="+idx;
				int cnt = stmt.executeUpdate(sql);
				if(cnt == 1) result = true;
				else result = false;
			 }else {
				 result = false;
			 }
		}catch (Exception e) {
			System.out.println("boardDelete Exception : "+e);
		} finally {
			if(stmt != null) stmt.close();
			pool.releseConnection(conn);
		}
		return result;
	}//boardDelete end
	
	//�˻����� �� ����
	public int boardCount(String find, String search) throws SQLException{
		int cnt = 0;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = pool.getConnection();
			stmt = conn.createStatement();
			String sql = "select count(*) from "+board+" where "
					+find+" like "+" '%"+search+"%' ";
			rs = stmt.executeQuery(sql);
			rs.next();
			cnt = rs.getInt(1);
		}catch (Exception e) {
			System.out.println("boardCount Exception : "+e);
		} finally {
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			pool.releseConnection(conn);
		}
		return cnt;
	}//boardCount end
	
	//
	public Vector getSearchList(int offset, int limit, String find, String search) throws SQLException{
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector searchList = new Vector();
		try {
			conn = pool.getConnection();
			stmt = conn.createStatement();
			sql = "select a.* from ( select ROWNUM as RN, b.* from "
						+"(select * from "+board+" where "+find+" like "+" '%"+search+"%' order by idx desc)b"
					+")a where a.RN > "+offset+" and a.RN <= "+(offset+limit);
			
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setIdx(rs.getInt("idx"));
				bb.setHit(rs.getInt("hit"));
				bb.setName(rs.getString("name"));
				bb.setEmail(rs.getString("email"));
				bb.setHomepage(rs.getString("homepage"));
				bb.setTitle(rs.getString("title"));
				String content = rs.getString("content");
				content = content.replaceAll("\n", "<br>");
				bb.setContent(content);
				bb.setWdate(rs.getString("wdate").substring(0,10));
				
				searchList.add(bb);
			}//while
		} catch (Exception e) {
			System.out.println("getSearchList Exception : "+e);
		} finally {
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			pool.releseConnection(conn);
		}
		return searchList;
	}//getSearchList end
	
	
}// class end
