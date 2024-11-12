/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.marketer;

import dal.db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Brand;
import model.Category;

/**
 *
 * @author Acer
 */
public class BrandDAO extends DBContext {

    //doc tat ca bang categories :
    public List<Brand> getAllBrands() {
        List<Brand> list = new ArrayList<>();
        //Lenh sql: select * from category
        String sql = "SELECT [brandID]\n"
                + "      ,[brandName]\n"
                + "      ,[description]\n"
                + "  FROM [dbo].[Brand]";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Brand c = new Brand(rs.getInt("brandID"),
                        rs.getString("brandName"),rs.getString("description"));
                list.add(c);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return list;
    }
}