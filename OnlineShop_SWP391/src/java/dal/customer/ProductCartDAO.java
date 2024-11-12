/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.customer;

import dal.db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Products;

/**
 *
 * @author MSI1
 */
public class ProductCartDAO extends DBContext {

    public List<Products> getAllProduct() {
        String sql = "select * from Products";

        List<Products> listProduct = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            //ps.setInt(1, cid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Products c = new Products(rs.getInt("productID"),
                        rs.getString("productName"),
                        rs.getFloat("importPrice"),
                        rs.getFloat("price"),
                        rs.getInt("catID"),
                        rs.getInt("brandID"),
                        rs.getString("briefInfo"),
                        rs.getString("description"),
                        rs.getDate("createdAt"),
                        rs.getInt("quantity"),
                        rs.getInt("status"),
                        rs.getInt("featureStatus")
                );

                listProduct.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listProduct;
    }

    public static void main(String[] args) {
        List<Products> listProduct = new ProductCartDAO().getAllProduct();
        System.out.println(listProduct);
    }

}
