package com.yz.shiro.api.dao;


import com.yz.shiro.api.entity.Area;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface AreaMapper extends DaoManager<Area> {

    long selectAllChildCount(Map param);

    boolean updateAllChildPatentIds(Map params);

    boolean updateAllChildStatus(Map params);
}