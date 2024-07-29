package com.fastcms.vo;

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
public class ConfigVo implements Serializable {

    private static final long serialVersionUID = 1L;


    private Long id;

    /**
     * 配置key键值
     */

    private String key;

    private String typeId;

    /**
     * 配置值
     */

    private String value;

    private String label;


    private LocalDateTime created;


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

    public Object getJsonValue() {
        return "true".equalsIgnoreCase(value) || "false".equalsIgnoreCase(value) ? Boolean.valueOf(value) : value;
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

    @Override
    public String toString() {
        return "Config{" +
            "id=" + id +
            ", key=" + key +
            ", value=" + value +
        "}";
    }
}
