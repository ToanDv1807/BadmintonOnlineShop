/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

public class Setting {

    private int setting_id;
    private int type;
    private int order;
    private String value;
    private String description;
    private boolean status;
    private String type_String;

    public Setting(int setting_id, int type, int order, String value, String description, boolean status) {
        this.setting_id = setting_id;
        this.type = type;
        this.order = order;
        this.value = value;
        this.description = description;
        this.status = status;
    }

    public Setting(int setting_id, int type, int order, String value, String description, boolean status, String type_String) {
        this.setting_id = setting_id;
        this.type = type;
        this.order = order;
        this.value = value;
        this.description = description;
        this.status = status;
        this.type_String = type_String;
    }

    public Setting() {
    }

    public int getSetting_id() {
        return setting_id;
    }

    public void setSetting_id(int setting_id) {
        this.setting_id = setting_id;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getType_String() {
        return type_String;
    }

    public void setType_String(String type_String) {
        this.type_String = type_String;
    }

    @Override
    public String toString() {
        return "Setting{" + "setting_id=" + setting_id + ", type=" + type + ", order=" + order + ", value=" + value + ", description=" + description + ", status=" + status + ", type_String=" + type_String + '}';
    }

}
