package com.yz.shiro.dao;

import java.util.List;

import com.yz.shiro.entity.App;

/**
 * 
* @ClassName: AppMapper 
* @Description: 应用
* @author yangyw(imalex@163.com)
* @date 2015年3月20日 下午1:56:00 
*
 */
public interface AppMapper {
    boolean deleteByPrimaryKey(Long id);

    int insert(App record);

    int insertSelective(App record);

    App selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(App record);

    int updateByPrimaryKey(App record);
    
    List<App> select(App app);
    
    Long selectAppIdByAppKey(String appKey);

    List<App> selectByIds(List<Long> ids);
}