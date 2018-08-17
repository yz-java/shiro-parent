package com.yz.shiro.api.service;

import com.yz.shiro.entity.Area;

import java.util.List;

/**
 * @author yangzhao
 *         create by 17/12/18
 */
public interface AreaService extends BaseService<Area> {
    /**
     * 区域信息获取
     * @param area
     * @return
     */
    public List<Area> get(Area area);

    /**
     * 区域添加
     * @param area
     * @return
     */
    public boolean add(Area area);

    /**
     * 区域修改
     * @param area
     * @return
     */
    public boolean updateById(Area area);

    /**
     * 修改状态
     * @param id
     * @param status
     * @param updateChildStatus 是否修改所有子节点的状态
     * @return
     */
    public boolean updateDelFlagById(Long id,boolean status,boolean updateChildStatus);

}
