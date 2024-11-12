/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.customer;

import dal.db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Address;

/**
 *
 * @author LENNOVO
 */
public class AddressDAO extends DBContext {

    public int getLastAddressID() {
        String sql = "SELECT TOP 1 addressID FROM Address ORDER BY addressID DESC";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();

            // Kiểm tra nếu ResultSet không có kết quả
            if (rs.next()) {
                return rs.getInt(1); // Trả về addressID nếu có kết quả
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Nên ghi lại lỗi để dễ dàng kiểm tra
        }
        return 0; // Trả về 0 nếu không có kết quả
    }

    public int countNumberOfAddress(int customerID) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Address WHERE customerID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, customerID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public boolean insertNewAddress(int addressID, String addressName, int customerID) {
        String sql = "INSERT INTO Address (addressID, addressName, customerID, status) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);

            // Thiết lập các tham số cho câu lệnh SQL
            stm.setInt(1, addressID);
            stm.setString(2, addressName);
            stm.setInt(3, customerID);
            stm.setString(4, "1"); // hoặc bất kỳ giá trị nào bạn muốn cho cột status

            // Thực hiện chèn dữ liệu
            int rowsAffected = stm.executeUpdate();

            // Trả về true nếu có ít nhất một dòng được chèn thành công
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // Ghi lại lỗi để dễ dàng kiểm tra
        }
        return false; // Trả về false nếu có lỗi xảy ra
    }

    public void updatedPrimaryAddress(String editedAddress, int customerID) {
        String sql = "update Customers\n"
                + "set address = ?\n"
                + "where customerID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);

            // Thiết lập các tham số cho câu lệnh SQL
            stm.setString(1, editedAddress);
            stm.setInt(2, customerID);
            // Thực hiện chèn dữ liệu
            int rowsAffected = stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // Ghi lại lỗi để dễ dàng kiểm tra
        }
    }

    public void updatedAddress(int addressID, String editedAddress) {
        String sql = "Update Address\n"
                + "set addressName = ?\n"
                + "where addressID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);

            // Thiết lập các tham số cho câu lệnh SQL
            stm.setString(1, editedAddress);
            stm.setInt(2, addressID);
            // Thực hiện chèn dữ liệu
            int rowsAffected = stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // Ghi lại lỗi để dễ dàng kiểm tra
        }
    }

    public boolean deleteAdress(int addressID) {
        String sql = "Delete from Address where addressID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, addressID);
            // Thực hiện chèn dữ liệu
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // Ghi lại lỗi để dễ dàng kiểm tra
        }
        return false;
    }

    public Address getAddressByAddressID(int addressID) {
        String sql = "Select * from Address Where addressID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, addressID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Address(rs.getInt(1), rs.getString(2), rs.getInt(3));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
