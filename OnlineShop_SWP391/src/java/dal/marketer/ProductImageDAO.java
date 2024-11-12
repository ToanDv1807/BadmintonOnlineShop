/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.marketer;

import dal.db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author MSI1
 */
public class ProductImageDAO extends DBContext {

    public String getImageURLByProductId(int productID) {
       
        String sql = "select pm.productImgUrl\n"
                + "from ProductImage pm\n"
                + "join Products p on pm.productID = p.productID\n"
                + "where p.productID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setObject(1, productID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                 String url = rs.getString("productImgUrl");
                 return url;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    

    public static void main(String[] args) {
        ProductImageDAO dao = new ProductImageDAO();
        String url = dao.getImageURLByProductId(1);
        System.out.println(url);
    }
}
