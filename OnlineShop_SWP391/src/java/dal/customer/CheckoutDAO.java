/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.customer;

import dal.db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.CartItem;
import model.Customers;

/**
 *
 * @author MSI1
 */
public class CheckoutDAO extends DBContext{

    public Customers getProfileCustomerByCustomerId(int customerID) {
        Customers customers = new Customers();
        String sql = "select c.fullName,c.gender, c.email,c.phone, c.address\n"
                + "from Customers c\n"
                + "where c.customerID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setObject(1, customerID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String fullName = rs.getString("fullName");
                int gender = rs.getInt("gender");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                customers = new Customers(fullName, gender, email, phone, address);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return customers;
    }
    public static void main(String[] args) {
        CheckoutDAO cd = new CheckoutDAO();
        Customers customers = cd.getProfileCustomerByCustomerId(5);
        System.out.println(customers);
    }
}
