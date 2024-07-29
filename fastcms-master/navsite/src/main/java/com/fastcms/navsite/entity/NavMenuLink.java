package com.fastcms.navsite.entity;

import java.io.Serializable;

public class NavMenuLink implements Serializable {

    private Long menuId;

    private Long linkId;


    public Long getMenuId() {
        return menuId;
    }

    public void setMenuId(Long menuId) {
        this.menuId = menuId;
    }

    public Long getLinkId() {
        return linkId;
    }

    public void setLinkId(Long linkId) {
        this.linkId = linkId;
    }
}
