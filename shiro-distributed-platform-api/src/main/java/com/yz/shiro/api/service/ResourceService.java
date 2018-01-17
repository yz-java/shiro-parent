package com.yz.shiro.api.service;

import com.yz.shiro.api.entity.Resource;

import java.util.List;
import java.util.Set;

/**
 * 资源
* @ClassName: ResourceService 
* @Description: 系统资源
* @author yangzhao
* @date 2017年12月20日 下午2:05:41
*
 */
public interface ResourceService {

    public final String CACHE_FLAG = "all_resource";


    /**
     * 资源添加
     * @param resource
     * @return
     */
    public boolean createResource(Resource resource);

    /**
     * 通过ID修改资源信息
     * @param resource
     * @return
     */
    public boolean updateResourceById(Resource resource);

    public void deleteResource(Long resourceId);

    Resource findOne(Long resourceId);
    List<Resource> findAll();

    /**
     * 得到资源对应的权限字符串
     * @param resourceIds
     * @return
     */
    Set<String> findPermissions(Set<Long> resourceIds);

    /**
     * 资源查询
     * @param resource
     * @return
     */
    List<Resource> getByResource(Resource resource);

    /**
     * 删除
     * @param id
     * @param status
     * @param updateAllChild 是否修改所有子节点
     * @return
     */
    boolean updateStatusById(Long id,boolean status,boolean updateAllChild);

    /**
     * 获取资源信息
     * @param ids
     * @return
     */
    List<Resource> getByIds(List<Long> ids);

    /**
     * 通过权限标识获取资源列表
     * @param permissions
     * @return
     */
    List<Resource> getByPermissionList(List<String> permissions);

    /**
     * 缓存所有资源
     */
    public void cacheAllResources();

    /**
     * 获取资源信息
     * @param id
     * @return
     */
    public Resource getById(Long id);
}
