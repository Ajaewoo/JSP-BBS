package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
			String dbuser = "C##DOBINNA";
			String dbpassword = "12345";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbuser, dbpassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {
		String sql = "SELECT userPassword FROM USERS WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; //로그인 성공
				}else 
					return 0; //비밀번호 불일치
			}
			return -1; //아이디 없음
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return -2; //데이터베이스 오류
		
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO USERS VALUES (?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	
	
	

}
