package com.yz.shiro.server.form;

import com.yz.shiro.api.entity.Role;

/**
 * @author yangzhao
 *         create by 17/12/20
 */
public class RoleForm extends Role {

    private boolean selected;

    public boolean isSelected() {
        return selected;
    }

    public void setSelected(boolean selected) {
        this.selected = selected;
    }
}
