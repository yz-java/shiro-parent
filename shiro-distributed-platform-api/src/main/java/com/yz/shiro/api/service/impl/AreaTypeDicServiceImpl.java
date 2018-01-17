package com.yz.shiro.api.service.impl;

import com.yz.shiro.api.dao.AreaTypeDicMapper;
import com.yz.shiro.api.entity.AreaTypeDic;
import com.yz.shiro.api.service.AreaTypeDicService;
import com.yz.shiro.api.service.BaseServiceManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author yangzhao
 * @Description
 * @Date create by 13:05 18/1/2
 */
@Service
public class AreaTypeDicServiceImpl extends BaseServiceManager<AreaTypeDic,AreaTypeDicMapper> implements AreaTypeDicService {
    @Override
    @Autowired
    public void setDao(AreaTypeDicMapper areaTypeDicMapper) {
        this.dao = areaTypeDicMapper;
    }

    @Override
    public List<AreaTypeDic> selectPageList(AreaTypeDic areaTypeDic, int pageIndex, int pageSize) {
        return null;
    }
}
