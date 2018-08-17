package com.yz.shiro.api.impl;

import com.yz.shiro.dao.AuthorizationMapper;
import com.yz.shiro.entity.User;
import com.yz.shiro.api.service.AppService;
import com.yz.shiro.api.service.AuthorizationService;
import com.yz.shiro.entity.Authorization;
import com.yz.shiro.api.service.RoleService;
import com.yz.shiro.api.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 
* @ClassName: AuthorizationServiceImpl 
* @Description: 权限
* @author yangyw(imalex@163.com)
* @date 2015年3月20日 下午2:04:20 
*
 */
@Service
public class AuthorizationServiceImpl implements AuthorizationService {

    @Autowired
    private AuthorizationMapper authorizationMapper;
    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private AppService appService;

    @Resource
    private RedisTemplate redisTemplate;

    @Override
    public Authorization createAuthorization(Authorization authorization) {
        return merge(authorization);
    }

    @Override
    public Authorization updateAuthorization(Authorization authorization) {
        boolean b = authorizationMapper.updateByPrimaryKeySelective(authorization);
        if (!b){
            return null;
        }
        return authorization;
    }

    public Authorization merge(Authorization authorization) {
    	Map<String,Object> map=new HashMap<String,Object>();
    	map.put("appId", authorization.getAppId());
    	map.put("userId",authorization.getUserId());
    	
        Authorization dbAuthorization = authorizationMapper.selectByAppUser(map);
        if(dbAuthorization ==  null) {//如果数据库中不存在相应记�? 直接新增
        	authorizationMapper.insertSelective(authorization);
            return authorization;
        }

        if(dbAuthorization.equals(authorization)) {//如果是同�?条记录直接更新即�?
        	authorizationMapper.updateByPrimaryKeySelective(authorization);
            return authorization;
        }
        //kaishi
        String zhongjianzhi=dbAuthorization.getRoleIds();
        String[] dbroleIds=dbAuthorization.getRoleIds().split(",");
        List<Long> dblist=new ArrayList<Long>();
        for(String dbroleId:dbroleIds){
        	dblist.add(Long.valueOf(dbroleId));
        }
        String[] roleIds=authorization.getRoleIds().split(",");
        for(String roleId:roleIds){
        	if(!dblist.contains(roleId)){
        		dblist.add(Long.valueOf(roleId));
        		zhongjianzhi=dbAuthorization.getRoleIds()+","+roleId;
        	}
        }
        dbAuthorization.setRoleIds(zhongjianzhi);

        if(dbAuthorization.getRoleIds().isEmpty()) {//如果没有角色 直接删除记录即可
            authorizationMapper.deleteByPrimaryKey(dbAuthorization.getId());
            return dbAuthorization;
        }
        //否则更新
        authorizationMapper.updateByPrimaryKeySelective(dbAuthorization);
        return dbAuthorization;
    }

    @Override
    public boolean deleteAuthorization(Long authorizationId) {
    	return authorizationMapper.deleteByPrimaryKey(authorizationId);
    }

    @Override
    public Authorization findOne(Long authorizationId) {    	
        return authorizationMapper.selectByPrimaryKey(authorizationId);
    }

    @Override
    public List<Authorization> findAll() {
        return authorizationMapper.selectAll();
    }

    /**
     * 根据用户名查找其角色
     * @param username
     * @return
     */
    @Override
    public Set<String> findRoles(String appKey, String username) {
        User user = userService.findByUsername(username);
        if(user == null) {
            return Collections.EMPTY_SET;
        }
        Long appId = appService.findAppIdByAppKey(appKey);
        if(appId == null) {
            return Collections.EMPTY_SET;
        }
        Map<String,Object> map=new HashMap<String,Object>();
    	map.put("appId", appId);
    	map.put("userId",user.getId());
    	
        Authorization authorization = authorizationMapper.selectByAppUser(map);
        if(authorization == null) {
            return Collections.EMPTY_SET;
        }
        
        String[] dbroleIds=authorization.getRoleIds().split(",");
        List<Long> dblist=new ArrayList<Long>();
        for(String dbroleId:dbroleIds){
        	dblist.add(Long.valueOf(dbroleId));
        }
        Long[] longs = dblist.toArray(new Long[dblist.size()]);
        return roleService.findRoles(longs);
    }

    /**
     * 根据用户名查找其权限
     * @param username
     * @return
     */
    @Override
    public Set<String> findPermissions(String appKey, String username) {
        User user = userService.findByUsername(username);
        if(user == null) {
            return Collections.EMPTY_SET;
        }
        Long appId = appService.findAppIdByAppKey(appKey);
        if(appId == null) {
            return Collections.EMPTY_SET;
        }
        Map<String,Object> map=new HashMap<String,Object>();
    	map.put("appId", appId);
    	map.put("userId",user.getId());
        Authorization authorization = authorizationMapper.selectByAppUser(map);
        if(authorization == null) {
            return Collections.EMPTY_SET;
        }
        //
        String[] dbroleIds=authorization.getRoleIds().split(",");
        List<Long> dblist=new ArrayList<Long>();
        for(String dbroleId:dbroleIds){
        	dblist.add(Long.valueOf(dbroleId));
        }
        //
        return roleService.findPermissions(dblist.toArray(new Long[0]));
    }

    @Override
    public List<Authorization> getByAuthorization(Authorization authorization) {
        List<Authorization> authorizations = authorizationMapper.select(authorization);
        return authorizations;
    }
}
