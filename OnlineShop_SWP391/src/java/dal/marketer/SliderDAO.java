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

import model.Slider;

/**
 *
 * @author Acer
 */
public class SliderDAO extends DBContext {

    //doc tat ca bang categories :
    public List<Slider> getAllSliders() {
        List<Slider> list = new ArrayList<>();
        //Lenh sql: select * from category
        String sql = "Select * from Sliders";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Slider c = new Slider(rs.getInt("sliderID"),
                        rs.getString("title"),
                        rs.getString("sliderImgUrl"),
                        rs.getInt("status"),
                        rs.getInt("employeeID"), rs.getString("createdDate"), rs.getString("backlink"), rs.getString("notes"));
                list.add(c);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return list;
    }

    public List<Slider> getPaginatedSliderList(int index) {
        List<Slider> list = new ArrayList<>();
        String sql = "select * from Sliders\n"
                + "order by sliderID\n"
                + "OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, (index - 1) * 10);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Slider(rs.getInt(1), rs.getString(2),
                        rs.getString(3), rs.getInt(4),
                        rs.getInt(5), rs.getString(6),
                        rs.getString(7), rs.getString(8)));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
        return list;
    }

}
