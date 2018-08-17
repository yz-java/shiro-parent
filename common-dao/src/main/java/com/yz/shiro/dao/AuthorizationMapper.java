package com.yz.shiro.dao;

import com.yz.shiro.entity.Authorization;

import java.util.List;
import java.util.Map;


/**
 * 
* @ClassName: AuthorizationMapper 
* @Description: 权限
* @author yangyw(imalex@163.com)
* @date 2015年3月20日 下午1:56:45 
*
 */
public interface AuthorizationMapper {
    boolean deleteByPrimaryKey(Long id);

    boolean insert(Authorization record);

    boolean insertSelective(Authorization record);

    Authorization selectByPrimaryKey(Long id);

    boolean updateByPrimaryKeySelective(Authorization record);

    boolean updateByPrimaryKey(Authorization record);
    
    public List<Authorization> selectAll();
    
    public Authorization selectByAppUser(Map<String, Object> map);

    public List<Authorization> select(Authorization authorization);
}