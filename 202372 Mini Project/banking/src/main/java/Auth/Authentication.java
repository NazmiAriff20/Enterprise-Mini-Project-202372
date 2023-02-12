package Auth;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;

import main.database;
public class Authentication{
	static HttpSession session;
	public static Boolean login_validate(AuthData data) {
		Boolean Status = false;
		try {
			String SQL = "SELECT * FROM ACCOUNTS WHERE ID = " + data.getAccNo() + " AND ONLINE_PIN = " + data.getPinNo();
			ResultSet res = database.prepare(SQL)
		.executeQuery();
		Status = res.next();
		}catch(Exception e) {
			System.out.print(e.getMessage());
		}
		return Status;
	}
	
	public static ArrayList<String> GetUserData(String AccId) {

		ArrayList<String> Result = new ArrayList<String>();
		try{

			if(AccId == "" || AccId == null) {
				return Result;
			}
			String SQL = "SELECT ID, NAME, EMAIL, BALANCE, CREATION_DATE " 
					   + "FROM ACCOUNTS WHERE ID = "+AccId;
			
			java.sql.ResultSet rs = main.database.prepare(SQL).executeQuery();
				if(rs.next()){
					Result.add(rs.getString(1));
					Result.add(rs.getString(2));
					Result.add(rs.getString(3));
					Result.add(rs.getString(4));
					Result.add(rs.getString(5));
				}
			}catch(Exception e){
				System.out.print(e.getMessage());
			}
		return Result;
	}
	
	public static Boolean SessionCheck(HttpSession session) {
		Boolean Status = false;
		if(session != null 
				&& session.getAttribute("session") != null
				&& session.getAttribute("session").toString().equals("TRUE")
				&& session.getAttribute("AccId") != null) {
			Status = true;
		}
		return Status;
	}
	
}