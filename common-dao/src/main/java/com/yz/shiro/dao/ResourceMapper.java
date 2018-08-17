package com.yz.shiro.dao;

import com.yz.shiro.entity.Resource;

import java.util.List;
import java.util.Map;

public interface ResourceMapper {

    boolean deleteByPrimaryKey(Long id);

    boolean insert(Resource record);

    boolean insertSelective(Resource record);

    Resource selectByPrimaryKey(Long id);

    boolean updateByPrimaryKeySelective(Resource record);

    boolean updateByPrimaryKey(Resource record);

    List<Resource> select(Resource resource);

    boolean updateParentIdsByParentIdsLike(Map params);

    boolean updateStatusByParentIdsLike(Map params);

    List<Resource> selectByIds(List<Long> ids);

    List<Resource> selectByPermissionList(List<String> permissions);

    List<Resource> selectByParentIdsLike(Map params);

}