package dal.common;

import dal.db.DBContext;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import model.Customers; 
import java.sql.ResultSet;

public class RegisterDAO extends DBContext {
    
    public static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
    // Phương thức đăng ký khách hàng
    public void registerCustomer(Customers customer) {
                PreparedStatement stm = null;
                RegisterDAO dao = new RegisterDAO();
                String hashedPassword = dao.hashPassword(customer.getPassword()); // Mã hóa mật khẩu
        try {
            String strInsert = "INSERT INTO Customers (email, password, fullName, img_url, phone, address, gender, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            stm = connection.prepareStatement(strInsert);
            stm.setString(1, customer.getEmail());
            stm.setString(2, hashedPassword);
            stm.setString(3, customer.getFullName());
            stm.setString(4, customer.getImg_url());
            stm.setString(5, customer.getPhone());  
            stm.setString(6, customer.getAddress());
            stm.setInt(7, customer.getGender());
            stm.setInt(8, customer.getStatus());
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException e) {
                System.out.println(e);
            }
        }
}
        // Phương thức kiểm tra khách hàng đã tồn tại
    public boolean checkCustomerExists(String email) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String strQuery = "SELECT COUNT(*) FROM Customers WHERE email = ?";
            stm = connection.prepareStatement(strQuery);
            stm.setString(1, email);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Nếu có ít nhất một bản ghi thì tài khoản đã tồn tại
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
        return false; // Nếu không có bản ghi nào thì tài khoản chưa tồn tại
    }
        public boolean checkEmployeesExists(String email) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String strQuery = "SELECT COUNT(*) FROM Employees WHERE email = ?";
            stm = connection.prepareStatement(strQuery);
            stm.setString(1, email);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Nếu có ít nhất một bản ghi thì tài khoản đã tồn tại
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
        return false; // Nếu không có bản ghi nào thì tài khoản chưa tồn tại
    }
        public static void main(String[] args) {
            System.out.println(RegisterDAO.hashPassword("123"));
    }
}
