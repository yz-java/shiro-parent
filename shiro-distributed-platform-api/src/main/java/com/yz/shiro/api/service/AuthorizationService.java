package com.yz.shiro.api.service;

import com.yz.shiro.api.entity.Authorization;

import java.util.List;
import java.util.Set;

/**
 * 
* @ClassName: AuthorizationService 
* @Description: 权限
* @author yangzhao
* @date 2017年12月20日 下午2:04:08
*
 */
public interface AuthorizationService {


    public Authorization createAuthorization(Authorization authorization);

    public Authorization updateAuthorization(Authorization authorization);

    public boolean deleteAuthorization(Long authorizationId);

    public Authorization findOne(Long authorizationId);

    public List<Authorization> findAll();

    /**
     * 根据AppKey和用户名查找其角色标识
     * @param username
     * @return
     */
    public Set<String> findRoles(String appKey, String username);

    /**
     * 根据AppKey和用户名查找权限字符标识
     * @param username
     * @return
     */
    public Set<String> findPermissions(String appKey, String username);

    /**
     * 获取授权信息
     * @param authorization
     * @return
     */
    public List<Authorization> getByAuthorization(Authorization authorization);


}
