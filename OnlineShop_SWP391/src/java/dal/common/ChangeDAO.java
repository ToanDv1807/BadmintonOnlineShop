/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.common;

import dal.db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Account;
import model.Customers;
import model.Employees;

/**
 *
 * @author Tan
 */
public class ChangeDAO extends DBContext {

    public Customers getCustomersByEmail(String email) {
        String sql = "select * from Customers\n"
                + "where email = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("customerid");
                String password = rs.getString("password");
                String imgUrl = rs.getString("img_url");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                String fullName = rs.getString("fullName");
                int gender = rs.getInt("gender");
                String createdDate = rs.getString("createdDate");
                int status = rs.getInt("status");
                String note = rs.getString("note");
                Customers c = new Customers(id, email, password, fullName, imgUrl, phone, address, gender, createdDate, status, note);
                return c;
            }
        } catch (SQLException e) {
            System.out.println("loi get object by Id: " + e);
        }
        return null;
    }

    public void updateCustomerPassword(String password, int userId) {
        String sql = "UPDATE [dbo].[Customers]\n"
                + "   SET [password] = ?\n"
                + "     \n"
                + " WHERE customerID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, password);
            ps.setInt(2, userId);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void updateEmployeePassword(String password, int userId) {
        String sql = "UPDATE [dbo].[Employees]\n"
                + "   SET [password] = ?\n"
                + "     \n"
                + " WHERE employeeid = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, password);
            ps.setInt(2, userId);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void updateCustomerProfile(String img, String phone, String address, String fullName, int userId, int gender) {
        String sql = "UPDATE [dbo].[Customers]\n"
                + "   SET "
                + "     [img_url] = ?\n"
                + "      ,[phone] = ?\n"
                + "      ,[address] = ?\n"
                + "      ,[fullName] = ?\n"
                + "      ,[gender] = ?\n"
                + " WHERE customerID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, img);
            ps.setString(2, phone);
            ps.setString(3, address);
            ps.setString(4, fullName);
            ps.setInt(5, gender);
            ps.setInt(6, userId);  // Corrected this line to bind customerID
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Loi updateProfile: " + e.getMessage());  // Log the exception for debugging
        }
    }

    public Customers getInformationOrderByEmailAndOrderID(String email, int orderID) {
        String sql = "select c.customerID, c.email, c.fullName, c.status,c.password, c.img_url,c.createdDate,c.phone, c.address, c.gender, o.orderID, o.orderDate, o.statusID, o.note, o.paymentMethod\n"
                + "from Customers c\n"
                + "join Orders o on c.customerID = o.customerID\n"
                + "where c.email = ? and o.orderID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setObject(1, email);
            ps.setObject(2, orderID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int customerID = rs.getInt("customerID");
                String password = rs.getString("password");
                String imgUrl = rs.getString("img_url");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                String fullName = rs.getString("fullName");
                int gender = rs.getInt("gender");
                String createdDate = rs.getString("createdDate");
                int status = rs.getInt("status");
                String note = rs.getString("note");
                String paymentMethod = rs.getString("paymentMethod");
                Customers customer = new Customers(customerID, email, password, fullName, imgUrl, phone, address, gender, createdDate, status, note, paymentMethod);
                return customer;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
