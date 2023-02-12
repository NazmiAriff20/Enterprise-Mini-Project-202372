import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import main.database;

/**
 * Servlet implementation class Api
 */
@WebServlet("/Api")
public class Api extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Api() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setStatus(403);
		response.getWriter().append("403 ForBidden Method Not Allowed");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		switch (request.getParameter("Method")) {
		
		case "CheckOut": {
			response.setStatus(200);
			response.getWriter().append(CheckOut(request,response));
			break;
		}
		
		default:
			doGet(request, response);
		}
	}

	protected String CheckOut(HttpServletRequest request, HttpServletResponse response) {
		
		String Name = request.getParameter("name");
		String AccNo = request.getParameter("accNo");
		String PinNo = request.getParameter("pinNo");
		Double TotalPrice = Double.parseDouble(request.getParameter("TotalPrice"));
		String Status = "0";
		JSONObject obj = new JSONObject();
		ResultSet res;
		try {
		res = database.prepare("SELECT ID,NAME,EMAIL,BALANCE FROM ACCOUNTS WHERE ID = "+AccNo+"AND ONLINE_PIN = "+PinNo).executeQuery();
			if(res.next()) {
				Double CurrentBalance = res.getDouble(4);
				String Email = res.getString(3);
				if(CurrentBalance <= TotalPrice) {
					Status = "-2";
				}else {
					
					if(request.getParameter("OTP") == null) {
						String OTP = "";
						try {
							URL url = new URL ("https://creative-crostata-e6b802.netlify.app/.netlify/functions/send-email?email="+Email);
							HttpURLConnection con = (HttpURLConnection)url.openConnection();
							con.setRequestMethod("POST");
							con.setDoOutput(true);
							int responseCode = con.getResponseCode();

							if (responseCode == HttpURLConnection.HTTP_OK) { //success
								BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
								String inputLine;
								StringBuffer resp = new StringBuffer();

								while ((inputLine = in.readLine()) != null) {
									resp.append(inputLine);
								}
								in.close();
								
								System.out.println(resp.toString());
								
								OTP = resp.toString();
								
								throw new Exception("Error");
							}

						}catch(Exception e) {}
						
						if(!OTP.equals("")) {
							int updated = database.prepare("UPDATE ACCOUNTS SET OTP = "+OTP+" WHERE ID = "+AccNo+" AND ONLINE_PIN = "+PinNo).executeUpdate();
							if(updated == 1) {
								Status = "1";
								obj.put("Name",Name);
								obj.put("Email",res.getString(3));
								obj.put("AccNo",AccNo);
								obj.put("PinNo",PinNo);
								obj.put("TotalPrice",TotalPrice);
							}
						}
						
					}
					else {
						String OTP = request.getParameter("OTP");
						ResultSet rs = database.prepare("SELECT ID FROM ACCOUNTS WHERE OTP = "+OTP+" AND ID = "+AccNo+" AND ONLINE_PIN = "+PinNo).executeQuery();
						if(rs.next()) {
							Double DeductedPrice = CurrentBalance-TotalPrice;
							int Deduted =  database.prepare("UPDATE ACCOUNTS SET BALANCE = "+DeductedPrice.toString()+" WHERE ID = "+AccNo).executeUpdate();
								if(Deduted == 1) {
									obj.put("Name",res.getString(2));
									obj.put("Email",res.getString(3));
									obj.put("Deduted",TotalPrice);
									Status = "2";
								}
						}else {
							Status = "0";
						}
					}
				}
			}else {
				Status = "-1";	
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		obj.put("status", Status);
		return obj.toJSONString();
	}
	
}
