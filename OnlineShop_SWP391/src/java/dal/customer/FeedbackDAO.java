/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.customer;

import dal.db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Feedback;
import model.Order;
import model.Products;

/**
 *
 * @author Tan
 */
public class FeedbackDAO extends DBContext {

    public List<Feedback> getFeedbacksByPID(int productID) {
        List<Feedback> list = new ArrayList<>();
        String sql = "select c.fullName, f.comment, f.rating, f.feedbackDate, s.sizeName "
                + "from Feedback f "
                + "join Customers c on f.customerID = c.customerID "
                + "join Size s on s.sizeID = f.sizeID "
                + "where f.productID = ? and f.status = 1 "
                + "order by f.feedbackDate desc";
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String name = rs.getString("fullName");
                String comment = rs.getString("comment");
                int rate = rs.getInt("rating");
                Date feedbackDate = rs.getDate("feedbackDate");
                String dateString = dateFormat.format(feedbackDate);
                String attributeValue = rs.getString("sizeName");
                // Add to the list of Feedback
                list.add(new Feedback(name, rate, comment, dateString, attributeValue));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Exception handling
        }
        return list; // Always return the list, even if it's empty
    }

    public int checkBuyer(int productID, int customerID) {
        String sql = "select count(*)\n"
                + "from Orders o join OrderDetail od on o.orderID=od.orderID\n"
                + "where customerID =? and od.productID =?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customerID);
            ps.setInt(2, productID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int countFeedbackByPid(int productID) {
        String sql = "select count(*)\n"
                + "from Feedback\n"
                + "where productID=? and status =1";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public float getAVGRatingBYPid(int productID) {
        String sql = "select AVG(rating)\n"
                + "from Feedback\n"
                + "where productID=? and status =1";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getFloat(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void addAFeedback(Feedback feedback) {
        String sql = "INSERT INTO [dbo].[Feedback]\n"
                + "           ([customerID]\n"
                + "           ,[comment]\n"
                + "           ,[rating]\n"
                + "           ,[feedbackDate]\n"
                + "           ,[productID]\n"
                + "           ,[status]\n"
                + "           ,[sizeID]\n"
                + "           ,[orderID])"
                + "     VALUES (?, ?, ?, ?, ?, ?,?,?)";

        // SimpleDateFormat is not necessary here if feedbackDate is already in Date format
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, feedback.getCustomerID());
            ps.setString(2, feedback.getContent());
            ps.setInt(3, feedback.getRated());

            // Assuming feedback.getFeedbackDate() returns a String, you should first parse it to java.util.Date
            // Then, convert java.util.Date to java.sql.Date
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date utilDate = formatter.parse(feedback.getFeedbackDate());

            // Convert java.util.Date to java.sql.Date
            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
            ps.setDate(4, sqlDate);

            ps.setInt(5, feedback.getProductID());
            ps.setInt(6, feedback.getStatus());
            ps.setInt(7, feedback.getSizeID());
            ps.setInt(8, feedback.getOrderID());
            ps.executeUpdate(); // Use executeUpdate() for INSERT queries
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int countNoOfFBOfCustomer(int customerID, int productID, String attributeValue, int orderID) {
        String sql = "select count(*)\n"
                + "from Feedback f join Size s on f.sizeID=s.sizeID\n"
                + "where customerID =? and productID=? and s.sizeName=? and orderID =?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customerID);
            ps.setInt(2, productID);
            ps.setString(3, attributeValue);
            ps.setInt(4, orderID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Feedback> getFeedbacksByCIDandPID(int customerID, int productID, int orderID, int sizeID) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT f.feedbackID, f.customerID, c.fullName, c.email, c.phone, p.productName, p.productID, f.rating, f.comment, f.status ,f.feedbackDate \n"
                + "                FROM Feedback f \n"
                + "                JOIN Customers c ON f.customerID = c.customerID \n"
                + "                JOIN Products p ON f.productID = p.productID \n"
                + "                WHERE c.customerID =? and p.productID =? and f.orderID=? and f.sizeID=? and f.status =1 \n"
                + "                order by f.feedbackDate desc";
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customerID);
            ps.setInt(2, productID);
            ps.setInt(3, orderID);
            ps.setInt(4, sizeID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int fID = rs.getInt("feedbackID");
                int cID = rs.getInt("customerID");
                String name = rs.getString("fullName");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String pname = rs.getString("productName");
                String comment = rs.getString("comment");
                int pID = rs.getInt("productID");
                int rate = rs.getInt("rating");
                int status = rs.getInt("status");
                Date feecbackDate = rs.getDate("feedbackDate");
                String dateString = dateFormat.format(feecbackDate);
                // Thêm vào danh sách Feedback
                list.add(new Feedback(fID, cID, name, email, phone, pname, pID, rate, comment, status, dateString));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ
        }
        return list;
    }

    public void updateFeedback(int feedbackID, int rating, String comment) {
        String sql = "UPDATE Feedback SET rating = ?, comment = ? ,feedbackDate =? WHERE feedbackID = ?";
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, rating);
            ps.setString(2, comment);
            Date date = new Date();

            // Convert java.util.Date to java.sql.Date
            java.sql.Date sqlDate = new java.sql.Date(date.getTime());
            ps.setDate(3, sqlDate);
            ps.setInt(4, feedbackID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int countNumberBuyOfProduct(int productID, int customerID, int orderID, String attributeValue) {
        String sql = "select COUNT(o.orderID)\n"
                + "from Orders o join OrderDetail od on o.orderID=od.orderID\n"
                + "join Size s on od.sizeID=s.sizeID\n"
                + "where customerID = ? and productID =? and o.orderID =? and s.sizeName=? and o.statusID =7";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customerID);
            ps.setInt(2, productID);
            ps.setInt(3, orderID);
            ps.setString(4, attributeValue);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Feedback getFeedbackByFID(int feedbackID) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT f.feedbackID, f.customerID, c.fullName, c.email, c.phone, p.productName, p.productID, f.rating, f.comment, f.status ,f.feedbackDate "
                + "FROM Feedback f "
                + "JOIN Customers c ON f.customerID = c.customerID "
                + "JOIN Products p ON f.productID = p.productID "
                + "WHERE f.feedbackID =? and f.status =1 "
                + "order by f.feedbackDate desc";
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, feedbackID);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int fID = rs.getInt("feedbackID");
                int cID = rs.getInt("customerID");
                String name = rs.getString("fullName");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String pname = rs.getString("productName");
                String comment = rs.getString("comment");
                int pID = rs.getInt("productID");
                int rate = rs.getInt("rating");
                int status = rs.getInt("status");
                Date feecbackDate = rs.getDate("feedbackDate");
                String dateString = dateFormat.format(feecbackDate);
                // Thêm vào danh sách Feedback
                return new Feedback(feedbackID, cID, name, email, phone, pname, pID, rate, comment, status, dateString);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ
        }
        return null;
    }

    public List<Products> getListProductIDByOrderID(int orderID) {
        List<Products> list = new ArrayList<>();
        String sql = "select od.productID, p.productName, s.sizeName\n"
                + "from OrderDetail od join Products p on od.productID=p.productID\n"
                + "join Size s on s.sizeID=od.sizeID\n"
                + "where orderID=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderID);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Products(rs.getInt("productID"), rs.getString("productName"), rs.getString("sizeName")));
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ
        }
        return null;
    }

    public List<Products> getTop3ProductRated() {
        List<Products> list = new ArrayList<>();
        String sql = "select top 3 p.productID ,p.productName,p.price\n"
                + "from Feedback f join Products p on f.productID =p.productID\n"
                + "group by p.productID,p.productName,p.price\n"
                + "order by AVG(rating) desc";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Products(rs.getInt("productID"), rs.getString("productName"), rs.getFloat("price")));
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ
        }
        return null;
    }

    public List<Feedback> getAvgRateForEachPro() {
        List<Feedback> list = new ArrayList<>();
        String sql = "select p.productID ,AVG(rating) as avgRate\n"
                + "from Feedback f join Products p on f.productID =p.productID\n"
                + "group by p.productID";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Feedback(rs.getInt("productID"), rs.getInt("avgRate")));
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ
        }
        return null;
    }

    public int getSizeIDByName(String sizeName) {
        String sql = "select sizeID\n"
                + "from Size\n"
                + "where sizeName=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, sizeName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ
        }
        return 0;
    }

    public static void main(String[] args) {
        FeedbackDAO fdao = new FeedbackDAO();
        fdao.getFeedbacksByPID(1);
    }
}
