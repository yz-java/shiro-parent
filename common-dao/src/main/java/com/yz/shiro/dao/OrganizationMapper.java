package com.yz.shiro.dao;

import com.yz.shiro.entity.Organization;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface OrganizationMapper extends DaoManager<Organization> {

    List<Organization> selectAllWithExclude(Map params);

    List<Organization> selectByParentId(Long parentId);

    List<Organization> select(Organization organization);

    boolean elementMoveById(Map params);

    boolean nodeMove(Map params);

    boolean updateAllChildStatusByParentIds(Map params);
}