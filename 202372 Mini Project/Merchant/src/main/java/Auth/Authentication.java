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
			String SQL = String.format("SELECT * FROM MERCHANT_USERS WHERE EMAIL = '%s' AND PASSWORD = '%s'",data.getEmail(),data.getPassword());
			ResultSet res = database.prepare(SQL)
		.executeQuery();
		Status = res.next();
		}catch(Exception e) {
			System.out.print(e.getMessage());
		}
		return Status;
	}
	
	public static int Register(AuthData data) {
		int Status = 0;
		try {
			ResultSet res = database.prepare(String.format("SELECT ID FROM MERCHANT_USERS WHERE EMAIL = '%s'",data.getEmail())).executeQuery();
			if(!res.next()) {
			String SQL = String.format("INSERT INTO MERCHANT_USERS (NAME,EMAIL,PHONE,ACCOUNT_NO,PASSWORD)"
										+ "VALUES('%s','%s','%s','%s','%s')",
										data.getName(),data.getEmail(),data.getPhone(),
										data.getAccNo(),data.getPassword());
			Status = database.prepare(SQL).executeUpdate();
			
			}else {
				Status = 2;
			}
		}catch(Exception e) {
			System.out.print(e.getMessage());
		}
		return Status;
	}
	
	public static ArrayList<String> GetUserData(String Email) {

		ArrayList<String> Result = new ArrayList<String>();
		try{

			if(Email == "" || Email == null) {
				return Result;
			}
			String SQL = "SELECT * FROM MERCHANT_USERS WHERE EMAIL = " + Email;
			
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
				&& session.getAttribute("Email") != null) {
			Status = true;
		}
		return Status;
	}
	
}