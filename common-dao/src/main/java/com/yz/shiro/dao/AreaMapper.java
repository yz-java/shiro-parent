package com.yz.shiro.dao;


import com.yz.shiro.entity.Area;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
public interface AreaMapper extends DaoManager<Area> {

    long selectAllChildCount(Map param);

    boolean updateAllChildPatentIds(Map params);

    boolean updateAllChildStatus(Map params);
}