package main;
import java.sql.*;

public class database {
	public static Connection conn = null;
	public static void Connect() {
		try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection("jdbc:oracle:thin:@fsktmdbora.upm.edu.my:1521:fsktm", "nky", "nky");
		}catch(Exception e) {
			System.out.print(e.getMessage());
		}
	}
	
	public static PreparedStatement prepare(String query) {
		PreparedStatement stmt = null;
		try {
			if(conn == null || conn.isClosed()) {
				Connect();
			}
			stmt=conn.prepareStatement(query,ResultSet.TYPE_SCROLL_INSENSITIVE , 
			         ResultSet.CONCUR_UPDATABLE ,
			         ResultSet.HOLD_CURSORS_OVER_COMMIT);
		}catch(Exception e) {
			System.out.print(e.getMessage());
		}
		return stmt;
	}
	
}
