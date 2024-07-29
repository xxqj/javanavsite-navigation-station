package com.fastcms.navsite.model;

import com.fastcms.common.model.TreeNode;
import com.fasterxml.jackson.annotation.JsonIgnore;

import java.io.Serializable;
import java.util.List;

/**
 * wjun_java@163.com
 * 对应element ui router
 */
public class NavLinkNode  implements Serializable {

    /**
     * 名称
     */
    private String value;
    /**
     * 路径
     */
    private String label;

    /**
     * id
     */
    protected Long id;
    /**
     * 上级id
     */
    protected Long parentId;

    private String icon;

    /**
     * 排序
     */
    protected int sortNum;

    private String isHide;

    private boolean isKeepAlive;



    //@JsonIgnore
    boolean hasChildren = false;

    private List<NavLinkNode> children;



    public NavLinkNode(Long id, Long parentId, String value, Integer sortNum,
                       String label, String icon, String isHide, Boolean isKeepAlive) {
        //super(id, parentId);
        this.value = value;
        this.label = label;
        this.id=id;
        this.parentId=parentId;
        this.sortNum=sortNum;
        this.icon=icon;
        this.isHide=isHide;
        this.isKeepAlive=isKeepAlive;

        //Children c = new Children(value, label, isHide, isKeepAlive);
       // this.children = c;
    }

    public List<NavLinkNode> getChildren() {
        return children;
    }

    public void setChildren(List<NavLinkNode> children) {
        this.children = children;
    }

    public boolean isHasChildren() {
        return hasChildren;
    }

    public void setHasChildren(boolean hasChildren) {
        this.hasChildren = hasChildren;
    }


    public int getSortNum() {
        return sortNum;
    }

    public void setSortNum(int sortNum) {
        this.sortNum = sortNum;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String isHide() {
        return isHide;
    }

    public void setHide(String hide) {
        isHide = hide;
    }

    public boolean isKeepAlive() {
        return isKeepAlive;
    }

    public void setKeepAlive(boolean keepAlive) {
        isKeepAlive = keepAlive;
    }
}
