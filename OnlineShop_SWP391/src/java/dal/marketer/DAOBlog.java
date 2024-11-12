/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.marketer;

import dal.db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Blog;
import model.BlogCategories;
import model.BlogSubtitles;
import model.Employees;

/**
 *
 * @author LENNOVO
 */
public class DAOBlog extends DBContext {

    public List<Blog> getTop4Lastest() {
        List<Blog> list = new ArrayList<>();
        String sql = "select top 4 * from Blog where status = 1\n"
                + "order by blogID desc";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Blog(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getInt(8), rs.getInt(9), rs.getInt(10), rs.getInt(11)));
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public List<Blog> getAllBlog() {
        List<Blog> list = new ArrayList<>();
        String sql = "select * from Blog\n";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Blog(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getInt(8), rs.getInt(9), rs.getInt(10), rs.getInt(11)));
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public List<BlogCategories> getAllBlogCategories() {
        List<BlogCategories> list = new ArrayList<>();
        String sql = "select * from BlogCategories";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new BlogCategories(rs.getInt(1), rs.getString(2)));
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public List<Blog> getAllBlogByCategoryBlogId(int cid) {
        List<Blog> list = new ArrayList<>();
        String sql = "select * from Blog p\n"
                + "where CategoryID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, cid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Blog(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getInt(8), rs.getInt(9), rs.getInt(10), rs.getInt(11)));
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public List<Blog> get2BlogByCategoryBlogId(int cid) {
        List<Blog> list = new ArrayList<>();
        String sql = "select top 2 * from Blog p\n"
                + "where CategoryID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, cid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Blog(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getInt(8), rs.getInt(9), rs.getInt(10), rs.getInt(11)));
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public Blog getBlogByBlogID(int bid) {
        String sql = "select * from Blog\n"
                + "where blogID = ?;";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, bid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return new Blog(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getInt(8), rs.getInt(9), rs.getInt(10), rs.getInt(11));
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public List<BlogSubtitles> getBlogSubtitlesByBlogID(int bid) {
        List<BlogSubtitles> list = new ArrayList<>();
        String sql = "select subtitleID,Blog.blogID , subtitle, imgUrl, BlogSubtitles.content from BlogSubtitles, Blog\n"
                + "where Blog.blogID = BlogSubtitles.blogID AND Blog.blogID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, bid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new BlogSubtitles(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5)));
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public Employees getEmployeeByBlogID(int bid) {
        String sql = "select * from Employees\n"
                + "join Blog on Blog.employeeID = Employees.employeeID\n"
                + "where blogID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, bid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return new Employees(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6), rs.getInt(7));
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public List<Blog> getBlogsByName(String input) {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT * FROM Blog WHERE title LIKE ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            // Set the input parameter, with '%' wildcards for the LIKE search
            stm.setString(1, "%" + input + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Blog(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getInt(8), rs.getInt(9), rs.getInt(10), rs.getInt(11)));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
        return list;
    }

    public List<Blog> getPagingBlogByName(String input, int index) {
        List<Blog> list = new ArrayList<>();
        String sql = "select * from Blog\n"
                + "where title LIKE ?\n"
                + "order by updatedDate desc\n"
                + "OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + input + "%");
            stm.setInt(2, (index - 1) * 4);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Blog(rs.getInt(1), rs.getString(2),
                        rs.getString(3), rs.getString(4),
                        rs.getString(5), rs.getString(6),
                        rs.getString(7), rs.getInt(8),
                        rs.getInt(9), rs.getInt(10),
                        rs.getInt(11)));
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public List<Blog> getBlogsByCategoryID(int cid) {
        List<Blog> list = new ArrayList<>();
        String sql = "select top 2 * from Blog where categoryID > ? Or categoryID < ? and status = 1";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, cid);
            stm.setInt(2, cid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                // Assuming your Blog constructor takes these parameters in the correct order
                list.add(new Blog(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getInt(8), rs.getInt(9), rs.getInt(10), rs.getInt(11)));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
        return list;
    }

    public int getTotalBlogs() {
        String sql = "select count(*) from Blog where status = 1";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    public List<Blog> pagingBlog(int index) {
        List<Blog> list = new ArrayList<>();
        String sql = "select * from Blog\n"
                + "where status = 1\n"
                + "order by updatedDate desc\n"
                + "OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY;";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, (index - 1) * 4);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Blog(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getInt(8), rs.getInt(9), rs.getInt(10), rs.getInt(11)));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
        return list;
    }

    public List<Blog> getPagingBlogByCategoryBlogId(int cid, int index) {
        List<Blog> list = new ArrayList<>();
        String sql = "select * from Blog\n"
                + "where CategoryID = ?\n"
                + "order by updatedDate desc\n"
                + "OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, cid);
            stm.setInt(2, (index - 1) * 4);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Blog(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7),
                        rs.getInt(8), rs.getInt(9), rs.getInt(10), rs.getInt(11)));
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public String getCategoryNameByCID(int cid) {
        String sql = "select categoryName from BlogCategories\n"
                + "where categoryID = ?;";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, cid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                // Assuming your Blog constructor takes these parameters in the correct order
                return rs.getString(1);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
        return null;
    }

    public List<Blog> pagingBlogForMKT(int index) {
        List<Blog> list = new ArrayList<>();
        String sql = "select * from Blog\n"
                + "order by blogID\n"
                + "OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, (index - 1) * 10);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Blog(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(6),
                        rs.getString(7), rs.getInt(8),
                        rs.getInt(9), rs.getInt(10), rs.getInt(11)));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
        return list;
    }

    public int getLastBlogID() {
        String sql = "select top 1 * from Blog\n"
                + "order by blogID desc";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
        return -1;
    }

    public int getLastBlogSubtitle() {
        String sql = "select top 1 subtitleID from BlogSubtitles\n"
                + "order by BlogSubtitles.subtitleID desc";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
        return -1;
    }
}
