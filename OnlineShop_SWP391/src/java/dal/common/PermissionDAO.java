package dal.common;

import dal.db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PermissionDAO extends DBContext {

    // Phương thức trả về danh sách các URL mà roleID có thể truy cập
    public List<String> getPermissionsByRole(int roleID) {
        String sql = "SELECT url FROM Permission WHERE roleID = ?";
        List<String> urls = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, roleID);
            ResultSet rs = ps.executeQuery();

            // Lấy tất cả các URL mà roleID có thể truy cập
            while (rs.next()) {
                urls.add(rs.getString("url"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return urls;
    }
}
