package com.yz.shiro.api.dao;

import com.yz.shiro.api.entity.Role;
import java.util.List;

/**
 * 
* @ClassName: RoleMapper 
* @Description: 角色
* @author yangyw(imalex@163.com)
* @date 2015年3月20日 下午1:57:45 
*
 */
public interface RoleMapper {
    boolean deleteByPrimaryKey(Long id);

    boolean insert(Role record);

    boolean insertSelective(Role record);

    Role selectByPrimaryKey(Long id);

    boolean updateByPrimaryKeySelective(Role record);

    boolean updateByPrimaryKey(Role record);
    
    List<Role> select(Role role);
    
    Long selectCount();

    List<Role> selectByIdList(List<Long> ids);
}