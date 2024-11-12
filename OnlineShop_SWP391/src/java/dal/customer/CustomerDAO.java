/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.customer;

import dal.db.DBContext;
import java.security.spec.PSSParameterSpec;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Cart;
import model.Customers;

/**
 *
 * @author MSI1
 */
public class CustomerDAO extends DBContext {

    public boolean updatedCustomer(Customers c) {
        // Initialize SQL query
        String sql = "UPDATE Customers set fullName = ?, email = ?, phone = ? where customerID = ?";

        try {
            // Prepare the SQL statement
            PreparedStatement ps = connection.prepareStatement(sql);

            // Set the parameters for the prepared statement
            ps.setString(1, c.getFullName());
            ps.setString(2, c.getEmail());
            ps.setString(3, c.getPhone());
            ps.setInt(4, c.getCustomerID());
            // Execute the update query
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;  // Return true if rows were updated

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
