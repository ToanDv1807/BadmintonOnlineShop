package dal.common;

import dal.db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Account;
import dal.common.RegisterDAO;

public class LoginDAO extends DBContext {
    RegisterDAO dao = new RegisterDAO();
    public Account checkLogin(String email, String password) {
        String sqlEmployee = "SELECT email, password, employeeID, roleID, status FROM Employees WHERE email=? AND password=?";
        String sqlCustomer = "SELECT email, password FROM Customers WHERE email=? AND password=?";
        String hashedPassword = dao.hashPassword(password); // Mã hóa mật khẩu nhập vào
        try {
            // Kiểm tra trong bảng Employees
            PreparedStatement psEmployee = connection.prepareStatement(sqlEmployee);
            psEmployee.setString(1, email);
            psEmployee.setString(2, hashedPassword);
            ResultSet rsEmployee = psEmployee.executeQuery();

            if (rsEmployee.next()) {
                // Nếu tìm thấy trong Employees, trả về đối tượng Account với roleID
                return new Account(rsEmployee.getString("email"), rsEmployee.getString("password"), "Employee", rsEmployee.getInt("roleID"), rsEmployee.getInt("employeeID"), rsEmployee.getInt("status"));
            } else {
                // Nếu không tìm thấy trong Employees, kiểm tra bảng Customers
                PreparedStatement psCustomer = connection.prepareStatement(sqlCustomer);
                psCustomer.setString(1, email);
                psCustomer.setString(2, hashedPassword);
                ResultSet rsCustomer = psCustomer.executeQuery();

                if (rsCustomer.next()) {
                    // Nếu tìm thấy trong Customers, trả về đối tượng Account (roleID mặc định là 0 cho Customers)
                    return new Account(rsCustomer.getString("email"), rsCustomer.getString("password"), "Customer", 0);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Nếu không tìm thấy tài khoản
    }
}
