package main;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class helper{
	
	public static List<Product> GetProducts() {
		
		ResultSet res = null;
		List<Product> Products = new ArrayList<Product>();
		try {
			res = database.prepare("SELECT PRODUCT_ID, PRODUCT_NAME, DESCRIPTION, STANDARD_COST AS PRICE FROM PRODUCTS FETCH NEXT 20 ROWS ONLY").executeQuery();
			while (res.next()) {
				Product pr = new Product();
				pr.setId(res.getString(1));
				pr.setName(res.getString(2));
				pr.setDescription(res.getString(3));
				pr.setPrice(res.getString(4));
				Products.add(pr);
			}
		} catch (SQLException e) {
			System.out.print(e.getMessage());
		}
		
		return Products;
	}
	
public static Product GetProductById(String Id) {
		
		ResultSet res = null;
		Product pr = new Product();
		try {
			String SQL = "SELECT PRODUCT_ID, PRODUCT_NAME, DESCRIPTION, STANDARD_COST AS PRICE FROM PRODUCTS WHERE PRODUCT_ID = " + Id;
			res = database.prepare(SQL).executeQuery();
			while (res.next()) {
				pr.setId(res.getString(1));
				pr.setName(res.getString(2));
				pr.setDescription(res.getString(3));
				pr.setPrice(res.getString(4));
			}
		} catch (SQLException e) {
			System.out.print(e.getMessage());
		}
		
		return pr;
	}
	
}