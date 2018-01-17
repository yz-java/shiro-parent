package com.yz.shiro.api.service.impl;

import com.yz.shiro.api.dao.AreaMapper;
import com.yz.shiro.api.entity.Area;
import com.yz.shiro.api.service.AreaService;
import com.yz.shiro.api.service.BaseServiceManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.util.CollectionUtils;
import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author yangzhao
 *         create by 17/12/18
 */
@Service
public class AreaServiceImpl extends BaseServiceManager<Area,AreaMapper> implements AreaService {

    @Resource
    AreaMapper areaMapper;

    @Override
    @Autowired
    public void setDao(AreaMapper areaMapper) {
        this.dao = areaMapper;
    }

    @Override
    public List<Area> get(Area area) {
        List<Area> areas = areaMapper.select(area);
        return areas;
    }

    @Override
    public boolean add(Area area) {
        if (area.getParentId()==0){
            area.setParentIds("/0/");
        }else{
            Area a = new Area();
            a.setId(area.getParentId());
            List<Area> areas = get(a);
            if (!CollectionUtils.isEmpty(areas)){
                area.setParentIds(areas.get(0).getParentIds()+area.getParentId()+"/");
            }
        }
        boolean b = areaMapper.insertSelective(area);
        return b;
    }

    @Override
    public boolean updateById(Area area) {
        Area a = areaMapper.selectByPrimaryKey(area.getId());
        if (a==null){
            return false;
        }
        //用户上传ID
        Long parentId = area.getParentId();
        //当前ID
        Long pId = a.getParentId();

        if (parentId.equals(pId)){
            boolean b = areaMapper.updateByPrimaryKeySelective(area);
            return b;
        }

        Area parentArea = areaMapper.selectByPrimaryKey(parentId);
        area.setParentIds(parentArea.getParentIds()+parentArea.getId()+"/");
        boolean b = areaMapper.updateByPrimaryKeySelective(area);
        if (!b){
            return false;
        }
        Map params = new HashMap(1);
        params.put("parentIds",a.getParentIds() + a.getId() + "/");
        long count = areaMapper.selectAllChildCount(params);
        if (count==0){
            return b;
        }
        params = new HashMap(2);
        params.put("target",parentArea.getParentIds()+parentArea.getId()+"/"+a.getId());
        params.put("source",a.getParentIds()+a.getId()+"/");
        b = areaMapper.updateAllChildPatentIds(params);
        if (!b){
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
        }
        return true;
    }

    @Override
    public boolean updateDelFlagById(Long id, boolean status, boolean updateChildStatus) {
        Area area = new Area();
        area.setId(id);
        area.setaStatus(status);
        boolean b = areaMapper.updateByPrimaryKeySelective(area);
        if (!b){
            return false;
        }
        if (!updateChildStatus){
            return b;
        }
        area = areaMapper.selectByPrimaryKey(id);
        Map params = new HashMap(2);
        params.put("status",status);
        params.put("parentIds",area.getParentIds()+area.getId()+"/");
        b = areaMapper.updateAllChildStatus(params);
        if (!b){
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
        }
        return b;
    }

    @Override
    public boolean deleteById(Long id) {
        boolean b = areaMapper.deleteByPrimaryKey(id);
        return b;
    }

    @Override
    public List<Area> selectPageList(Area area, int pageIndex, int pageSize) {
        return null;
    }
}
