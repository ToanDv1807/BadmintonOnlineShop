package dal.admin;

import dal.db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Setting;
import model.Size;
import model.TypeSetting;

public class SettingDAO extends DBContext {

    public int getTotalSetting(String searchKey, String typeId, String status) {
        String sql = "Select count(*) from Setting "
                + "where [type] " + typeId + " and [status] " + status + " and [value] like N'%" + searchKey + "%'\n";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public List<Setting> getSettingWithPaging(int page, int PAGE_SIZE, String searchKey, String typeId, String orderType, String orderByField, String status) {
        List<Setting> list = new ArrayList<>();

        // Cập nhật toán tử cho SQL Server
        String sql = "SELECT setting_id, type, [order], [value], description, status "
                + "FROM Setting "
                + "WHERE [type] " + typeId + " AND [status] " + status + " AND [value] LIKE N'%" + searchKey + "%' "
                + "ORDER BY " + orderByField + " " + orderType + " "
                + "OFFSET (?-1) * ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            PreparedStatement st = connection.prepareStatement(sql);

            // Truyền các tham số
            st.setInt(1, page);
            st.setInt(2, PAGE_SIZE);
            st.setInt(3, PAGE_SIZE);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                int setting_id = rs.getInt("setting_id");
                int type = rs.getInt("type");
                int order = rs.getInt("order");
                String value = rs.getString("value");
                String description = rs.getString("description");
                boolean statusVal = rs.getBoolean("status");

                Setting c = new Setting(setting_id, type, order, value, description, statusVal);
                list.add(c);
            }

            return list;

        } catch (SQLException e) {
            System.out.println("SQL Error: " + e);
        }

        return null;
    }

    public List<TypeSetting> getAllSettingType() {
        List<TypeSetting> list = new ArrayList<>();
        String sql = "select * from Setting_Type ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                TypeSetting c = new TypeSetting();
                c.setId(rs.getInt(1));
                c.setName(rs.getString(2));

                list.add(c);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Setting getSettingById(int setting_id) {
        String sql = "select * from Setting s join Setting_Type st on s.type = st.setting_type_id where setting_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, setting_id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Setting c = new Setting();
                c.setSetting_id(rs.getInt(1));
                c.setType(rs.getInt(2));
                c.setOrder(rs.getInt(3));
                c.setValue(rs.getString(4));
                c.setDescription(rs.getString(5));
                c.setStatus(rs.getBoolean(6));
                c.setType_String(rs.getString(8));

                return c;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void updateSettingById(int settingId, String value, String description, int status) {
        String sql = "UPDATE [dbo].[Setting]\n"
                + "   SET [value] = ?\n"
                + "      ,[description] = ?\n"
                + "      ,[status] = ?\n"
                + " WHERE setting_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, value);
            st.setString(2, description);
            st.setInt(3, status);
            st.setInt(4, settingId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updateCategory(int order, String value, int status) {
        String sql = "UPDATE [dbo].[Category]\n"
                + "   SET [catName] = ?\n"
                + "      ,[status] = ?\n"
                + " WHERE catID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, value);
            st.setInt(2, status);
            st.setInt(3, order);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public int addCategory(String value, int status, String description) {
        String sql = "INSERT INTO [dbo].[Category]\n"
                + "           ([catName]\n"
                + "           ,[status]\n"
                + "           ,[description])\n"
                + "     VALUES\n"
                + "           (?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            st.setString(1, value);
            st.setInt(2, status);
            st.setString(3, description);
            st.executeUpdate();
            ResultSet rs = st.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public void addSettingBy(int type, int order, String value, String description, int status) {
        String sql = "INSERT INTO [dbo].[Setting]\n"
                + "           ([type]\n"
                + "           ,[order]\n"
                + "           ,[value]\n"
                + "           ,[description]\n"
                + "           ,[status])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, type);
            st.setInt(2, order);
            st.setString(3, value);
            st.setString(4, description);
            st.setInt(5, status);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updateOrderStatus(int order, String value, int status, int pre, int post) {
        String sql = "UPDATE [dbo].[Status]\n"
                + "   SET [statusName] = ?\n"
                + "      ,[status] = ?\n"
                + "      ,[pre] = ?\n"
                + "      ,[post] = ?\n"
                + " WHERE statusID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, value);
            st.setInt(2, status);
            st.setInt(3, pre);
            st.setInt(4, post);
            st.setInt(5, order);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public int addOrderStatus(String value, int status, int pre, int post) {
        String sql = "INSERT INTO [dbo].[Status]\n"
                + "           ([statusName]\n"
                + "           ,[status]\n"
                + "           ,[pre]\n"
                + "           ,[post])\n"
                + "     VALUES\n"
                + "           (?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            st.setString(1, value);
            st.setInt(2, status);
            st.setInt(3, pre);
            st.setInt(4, post);
            st.executeUpdate();
            ResultSet rs = st.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int addSize(String value, int status, int catID, String description) {
        String sql = "INSERT INTO [dbo].[Size]\n"
                + "           ([sizeName]\n"
                + "           ,[status]\n"
                + "           ,[attributeID]\n"
                + "           ,[catID]\n"
                + "           ,[description])\n"
                + "     VALUES\n"
                + "           (?,?,1,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            st.setString(1, value);
            st.setInt(2, status);
            st.setInt(3, catID);
            st.setString(4, description);
            st.executeUpdate();
            ResultSet rs = st.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }
    
public int getcatID(int sizeID) {
    String sql = "select catID from Size where sizeID = ?";
    try {
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, sizeID);  // Set the parameter before executing
        ResultSet rs = st.executeQuery();
        
        if (rs.next()) {  
            return rs.getInt("catID"); 
        }
    } catch (SQLException e) {
        System.out.println(e);
    }
    return 0; 
}

    public void updateSize(int order, String value, int status, int catID, String description) {
        String sql = "UPDATE [dbo].[Size]\n"
                + "   SET [sizeName] = ?\n"
                + "           ,[status]= ?\n"
                + "           ,[attributeID]= 1\n"
                + "           ,[catID]= ?\n"
                + "           ,[description]= ?\n"
                + " WHERE sizeID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, value);
            st.setInt(2, status);
            st.setInt(3, catID);
            st.setString(4, description);
            st.setInt(5, order);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        SettingDAO s = new SettingDAO();
        
    }
}
