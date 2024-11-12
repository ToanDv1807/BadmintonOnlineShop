package dal.common;

import dal.db.DBContext;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ResetDAO extends DBContext {
RegisterDAO dao = new RegisterDAO();
    // Hàm cập nhật mật khẩu cho tài khoản khách hàng
    public boolean updatePassword(String email, String newPassword) {
        String hashedPassword = dao.hashPassword(newPassword); // Mã hóa mật khẩu mới
        String strUpdate = "UPDATE Customers SET password = ? WHERE email = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(strUpdate)) {
            stm.setString(1, hashedPassword); // Sử dụng mật khẩu đã mã hóa
            stm.setString(2, email);
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu có bản ghi được cập nhật
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Trả về false nếu có lỗi xảy ra
        }
    }

    // Hàm cập nhật mật khẩu cho tài khoản nhân viên
    public boolean updatePasswordEmp(String email, String newPassword) {
        String hashedPassword = dao.hashPassword(newPassword); // Mã hóa mật khẩu mới
        String strUpdate = "UPDATE Employees SET password = ? WHERE email = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(strUpdate)) {
            stm.setString(1, hashedPassword); // Sử dụng mật khẩu đã mã hóa
            stm.setString(2, email);
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu có bản ghi được cập nhật
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Trả về false nếu có lỗi xảy ra
        }
    }
}
