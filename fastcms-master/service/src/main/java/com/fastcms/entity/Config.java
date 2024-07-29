package com.fastcms.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 系统配置
 * @author wjun_java@163.com
 * @since 2021-11-12
 */
public class Config implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 配置key键值
     */
    @TableField("`key`")
    private String key;

    /**
     * 配置值
     */
    @TableField("`value`")
    private String value;

    /**
     *
     * {value: '1',label: '系统参数'},
     * {value: '2',label: '公用参数'},
     * {value: '3',label: '用户参数'},
     * {value: '4',label: '参数列表'},
     * */
    @TableField
    private String typeId;

    @TableField
    private String label;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime created;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updated;

    /**
     * 排序
     */
    private Integer sortNum;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }
    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getTypeId() {
        return typeId;
    }

    public void setTypeId(String typeId) {
        this.typeId = typeId;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public LocalDateTime getCreated() {
        return created;
    }

    public void setCreated(LocalDateTime created) {
        this.created = created;
    }

    public LocalDateTime getUpdated() {
        return updated;
    }

    public void setUpdated(LocalDateTime updated) {
        this.updated = updated;
    }

    public Integer getSortNum() {
        return sortNum;
    }

    public void setSortNum(Integer sortNum) {
        this.sortNum = sortNum;
    }

    public Object getJsonValue() {
        return "true".equalsIgnoreCase(value) || "false".equalsIgnoreCase(value) ? Boolean.valueOf(value) : value;
    }

    @Override
    public String toString() {
        return "Config{" +
            "id=" + id +
            ", key=" + key +
            ", value=" + value +
        "}";
    }
}
