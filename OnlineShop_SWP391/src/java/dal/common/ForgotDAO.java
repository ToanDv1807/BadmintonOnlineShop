package dal.common;

import dal.db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Customers;
import model.Employees;

public class ForgotDAO extends DBContext {

    // Phương thức lấy khách hàng dựa trên email
    public Customers getCustomerByEmail(String email) {
        Customers customer = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            // Truy vấn để lấy thông tin khách hàng dựa trên email
            String strQuery = "SELECT * FROM Customers WHERE email = ?";
            stm = connection.prepareStatement(strQuery);
            stm.setString(1, email);
            rs = stm.executeQuery();

            // Kiểm tra và tạo đối tượng Customers nếu tìm thấy
            if (rs.next()) {
                customer = new Customers();
                customer.setEmail(rs.getString("email"));
                customer.setPassword(rs.getString("password"));
                customer.setFullName(rs.getString("fullName"));
                customer.setImg_url(rs.getString("img_url"));
                customer.setPhone(rs.getString("phone"));
                customer.setAddress(rs.getString("address"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException e) {
                System.out.println(e);
            }
        }
        return customer;
    }
        public Employees getEmployeesByEmail(String email) {
        Employees emp = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            // Truy vấn để lấy thông tin khách hàng dựa trên email
            String strQuery = "SELECT * FROM Employees WHERE email = ?";
            stm = connection.prepareStatement(strQuery);
            stm.setString(1, email);
            rs = stm.executeQuery();

            // Kiểm tra và tạo đối tượng Customers nếu tìm thấy
            if (rs.next()) {
                emp = new Employees();
                emp.setEmail(rs.getString("email"));
                emp.setPassword(rs.getString("password"));
                emp.setFullName(rs.getString("fullName"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException e) {
                System.out.println(e);
            }
        }
        return emp;
    }
}
