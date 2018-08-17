package com.yz.shiro.api.service;

import com.yz.shiro.entity.Role;

import java.util.List;
import java.util.Set;

/**
 * 
* @ClassName: RoleService 
* @Description: 系统角色
* @author yangzhao
* @date 2017年12月20日 下午2:06:05
*
 */
public interface RoleService {

    public final String CACHE_FLAG = "all_role";

    public Role createRole(Role role);

    public Role updateRole(Role role);

    public boolean deleteRole(Long roleId);

    public Role findOne(Long roleId);

    /**
     * 获取角色列表
     * @return
     */
    public List<Role> getByRole(Role role);


    /**
     * 根据角色编号得到角色标识符列�?
     * @param roleIds
     * @return
     */
    Set<String> findRoles(Long... roleIds);

    /**
     * 根据角色编号得到权限字符串列�?
     * @param roleIds
     * @return
     */
    Set<String> findPermissions(Long[] roleIds);

    /**
     * 获取所有角色数量
     * @return
     */
    public Long getAllCount();

    /**
     * 获取通过id获取角色列表
     * @param idList
     * @return
     */
    public List<Role> getByIdList(List<Long> idList);

    /**
     * 向缓存中加载又有角色信息
     * @return
     */
    public boolean cacheReloadAllRoles();
}
