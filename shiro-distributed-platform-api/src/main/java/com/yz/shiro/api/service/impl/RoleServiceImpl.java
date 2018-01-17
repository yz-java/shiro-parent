package com.yz.shiro.api.service.impl;

import com.yz.shiro.api.dao.RoleMapper;
import com.yz.shiro.api.entity.Role;
import com.yz.shiro.api.service.ResourceService;
import com.yz.shiro.api.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * 
* @ClassName: RoleServiceImpl 
* @Description: 角色
* @author yangyw(imalex@163.com)
* @date 2015年3月20日 下午2:06:17 
*
 */
@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleMapper roleMapper;
    @Autowired
    private ResourceService resourceService;

    @Resource
    private RedisTemplate redisTemplate;

    @Override
    public Role createRole(Role role) {
        role.setCreateTime(new Date());
    	roleMapper.insertSelective(role);
        redisTemplate.opsForHash().put(CACHE_FLAG,role.getId().toString(),role);
        return role;
    }

    @Override
    public Role updateRole(Role role) {
        boolean b = roleMapper.updateByPrimaryKeySelective(role);
        if (b){
            //更新缓存
            cacheReloadByIds(Arrays.asList(role.getId()));
            return role;
        }
        return null;
    }

    @Override
    public boolean deleteRole(Long roleId) {
        boolean b = roleMapper.deleteByPrimaryKey(roleId);
        if (b){
            redisTemplate.opsForHash().delete(CACHE_FLAG,roleId.toString());
        }
        return b;
    }

    @Override
    public Role findOne(Long roleId) {
    	return roleMapper.selectByPrimaryKey(roleId);
    }

    @Override
    public List<Role> getByRole(Role role) {
        List<Role> roles = roleMapper.select(role);
        return roles;
    }

    @Override
    public Set<String> findRoles(Long... roleIds) {
        List<Role> roleList = this.getByIdList(Arrays.asList(roleIds));
        Set<String> roles = roleList.stream().map(Role::getrCode).collect(Collectors.toSet());
        return roles;
    }

    @Override
    public Set<String> findPermissions(Long[] roleIds) {
        List<Role> roles = this.getByIdList(Arrays.asList(roleIds));
        Set<Long> resourceIds = new HashSet<>();
        roles.forEach(role -> {
            String[] split = role.getResourceIds().split(",");
            for (String resourceId:
                 split) {
                resourceIds.add(Long.parseLong(resourceId));
            }
        });
        return resourceService.findPermissions(resourceIds);
    }

    @Override
    public Long getAllCount() {
        Long count = roleMapper.selectCount();
        return count;
    }

    @Override
    public List<Role> getByIdList(List<Long> idList) {
        List<String> list = idList.stream().map(id -> id.toString()).collect(Collectors.toList());
        List<Role> roles = redisTemplate.opsForHash().multiGet(CACHE_FLAG, list);
        return roles;
    }

    @Override
    public boolean cacheReloadAllRoles() {
        Role role = new Role();
        role.setrStatus(true);
        List<Role> roles = roleMapper.select(role);
        Map<String,Object> roleMap = new HashMap<>(roles.size());
        roles.forEach(r->{
            roleMap.put(r.getId().toString(),r);
        });
        redisTemplate.opsForHash().putAll(CACHE_FLAG,roleMap);
        return true;
    }

    private void cacheReloadByIds(List<Long> ids){
        List<Role> roles = roleMapper.selectByIdList(ids);
        Map roleMap = new HashMap();
        roles.forEach(role -> {
            roleMap.put(role.getId().toString(),role);
        });
        redisTemplate.opsForHash().putAll(CACHE_FLAG,roleMap);
    }
}
