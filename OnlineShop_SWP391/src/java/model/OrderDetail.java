package model;

public class OrderDetail {

    private int orderDetailID;
    private int orderID;
    private int productID;
    private int quantity;
    private String note;
    private String category;
    // Thông tin về sản phẩm
    private Products product;  // Thêm thuộc tính product
    private int sizeID;
    private float price;

    public OrderDetail() {
    }

    public OrderDetail(int orderDetailID, int orderID, int productID, int quantity, int sizeID, float price) {
        this.orderDetailID = orderDetailID;
        this.orderID = orderID;
        this.productID = productID;
        this.quantity = quantity;
        this.sizeID = sizeID;
        this.price = price;
    }

    public OrderDetail(int productID, int sizeID, int quantity) {
        this.productID = productID;
        this.sizeID = sizeID;
        this.quantity = quantity;
    }

    public OrderDetail(int orderID, int productID, int quantity, int sizeID, float price) {
        this.orderID = orderID;
        this.productID = productID;
        this.quantity = quantity;
        this.sizeID = sizeID;
        this.price = price;
    }

    public OrderDetail(int orderDetailID, int orderID, int productID, int quantity, String note, String category, Products product, int sizeID, float price) {
        this.orderDetailID = orderDetailID;
        this.orderID = orderID;
        this.productID = productID;
        this.quantity = quantity;
        this.note = note;
        this.category = category;
        this.product = product;
        this.sizeID = sizeID;
        this.price = price;
    }

    public OrderDetail(int orderDetailID, int orderID, int productID, int quantity, int sizeID) {
        this.orderDetailID = orderDetailID;
        this.orderID = orderID;
        this.productID = productID;
        this.quantity = quantity;
        this.sizeID = sizeID;
    }

    public OrderDetail(int orderDetailID, int orderID, int productID, int quantity, String note, String category, Products product) {
        this.orderDetailID = orderDetailID;
        this.orderID = orderID;
        this.productID = productID;
        this.quantity = quantity;
        this.note = note;
        this.category = category;
        this.product = product;  // Gán product khi khởi tạo
    }

    public OrderDetail(int orderDetailID, int orderID, int productID, int quantity, String note, String category, Products product, int sizeID) {
        this.orderDetailID = orderDetailID;
        this.orderID = orderID;
        this.productID = productID;
        this.quantity = quantity;
        this.note = note;
        this.category = category;
        this.product = product;
        this.sizeID = sizeID;
    }

    public int getOrderDetailID() {
        return orderDetailID;
    }

    public void setOrderDetailID(int orderDetailID) {
        this.orderDetailID = orderDetailID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public Products getProduct() {
        return product;
    }

    public void setProduct(Products product) {
        this.product = product;
    }

    public int getSizeID() {
        return sizeID;
    }

    public void setSizeID(int sizeID) {
        this.sizeID = sizeID;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }
}
