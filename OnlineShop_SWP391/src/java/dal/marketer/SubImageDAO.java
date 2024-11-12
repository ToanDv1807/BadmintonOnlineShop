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
import model.Products;
import model.SubImage;

/**
 *
 * @author Acer
 */
public class SubImageDAO extends DBContext {

    public List<SubImage> getSubImageURLByProductImgId() {
        List<SubImage> list = new ArrayList<>();
        String sql = "select * from SubImage\n"
                ;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SubImage si = new SubImage(rs.getInt("subImgID"), rs.getInt("productImgID"), rs.getString("imgUrl"),rs.getInt("productID"));

                list.add(si);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return list;
    }

}
