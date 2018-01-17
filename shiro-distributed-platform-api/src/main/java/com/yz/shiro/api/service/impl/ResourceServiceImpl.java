package com.yz.shiro.api.service.impl;

import com.github.pagehelper.PageHelper;
import com.yz.shiro.api.dao.ResourceMapper;
import com.yz.shiro.api.entity.Resource;
import com.yz.shiro.api.service.ResourceService;
import org.apache.shiro.authz.permission.WildcardPermission;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author yangzhao
 * @ClassName: ResourceServiceImpl
 * @Description: 资源
 * @date 2017年12月20日 下午2:05:51
 */
@Service
public class ResourceServiceImpl implements ResourceService {

    @Autowired
    private ResourceMapper resourceMapper;

    @Autowired
    private RedisTemplate redisTemplate;

    @Override
    public boolean createResource(Resource resource) {
        resource.setCreateTime(new Date());
        boolean b = resourceMapper.insertSelective(resource);
        if (b) {
            redisTemplate.opsForHash().put(CACHE_FLAG, resource.getId().toString(), resource);
            return true;
        }
        return false;
    }

    @Override
    public boolean updateResourceById(Resource resource) {

        Resource sourceResource = resourceMapper.selectByPrimaryKey(resource.getId());
        Resource targetResource = resourceMapper.selectByPrimaryKey(resource.getParentId());
        resource.setParentIds(targetResource.getParentIds() + targetResource.getId() + "/");
        boolean b = resourceMapper.updateByPrimaryKeySelective(resource);

        if (!b) {
            return false;
        }
        if (sourceResource.getParentId().equals(resource.getParentId())) {
            //更新缓存
            cacheReloadByIds(Arrays.asList(resource.getId()));
            return b;
        }
        String targetParams = targetResource.getParentIds() + targetResource.getId() + "/" + sourceResource.getId();
        String sourceParams = sourceResource.getParentIds() + sourceResource.getId() + "/";

        Map params = new HashMap(2);
        params.put("targetParams", targetParams);
        params.put("sourceParams", sourceParams);

        b = resourceMapper.updateParentIdsByParentIdsLike(params);
        //更新缓存
        if (b) {
            params = new HashMap(1);
            params.put("parentIds", targetParams);
            List<Resource> resources = resourceMapper.selectByParentIdsLike(params);
            cacheReload(resources);
        }

        return b;
    }

    @Override
    public void deleteResource(Long resourceId) {
        resourceMapper.deleteByPrimaryKey(resourceId);
    }

    @Override
    public Resource findOne(Long resourceId) {
        return resourceMapper.selectByPrimaryKey(resourceId);
    }

    @Override
    public List<Resource> findAll() {
        Set keys = redisTemplate.opsForHash().keys(CACHE_FLAG);
        List<Resource> resources = redisTemplate.opsForHash().multiGet(CACHE_FLAG, keys);
        return resources;
    }

    @Override
    public Set<String> findPermissions(Set<Long> resourceIds) {
        Long[] longs = resourceIds.toArray(new Long[resourceIds.size()]);
        List<Resource> resources = getByIds(Arrays.asList(longs));
        if (CollectionUtils.isEmpty(resources)) {
            return Collections.EMPTY_SET;
        }
        Set<String> permissions = resources.stream().map(resource -> {
            return resource.getPermission() == null ? "" : resource.getPermission();
        }).collect(Collectors.toSet());
        return permissions;
    }

    private boolean hasPermission(Set<String> permissions, Resource resource) {
        if (StringUtils.isEmpty(resource.getPermission())) {
            return true;
        }
        for (String permission : permissions) {
            WildcardPermission p1 = new WildcardPermission(permission);
            WildcardPermission p2 = new WildcardPermission(resource.getPermission());
            if (p1.implies(p2) || p2.implies(p1)) {
                return true;
            }
        }
        return false;
    }

    @Override
    public List<Resource> getByResource(Resource resource) {
        List<Resource> resources = resourceMapper.select(resource);
        return resources;
    }

    @Override
    public boolean updateStatusById(Long id, boolean status, boolean updateAllChild) {
        Resource resource = new Resource();
        resource.setId(id);
        resource.setrStatus(status);
        boolean b = resourceMapper.updateByPrimaryKeySelective(resource);
        if (!b) {
            return b;
        }
        //更新缓存
        cacheReloadByIds(Arrays.asList(id));

        if (!updateAllChild) {
            return b;
        }
        resource = resourceMapper.selectByPrimaryKey(id);
        String parentIds = resource.getParentIds() + resource.getId();
        Map params = new HashMap(2);
        params.put("status", status);
        params.put("parentIds", parentIds);
        b = resourceMapper.updateStatusByParentIdsLike(params);
        if (!b) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
        }
        params = new HashMap(1);
        params.put("patentIds", parentIds);
        List<Resource> resources = resourceMapper.selectByParentIdsLike(params);
        cacheReload(resources);
        return b;
    }

    @Override
    public List<Resource> getByIds(List<Long> ids) {
        List<String> list = ids.stream().map(id -> id.toString()).collect(Collectors.toList());
        List<Resource> resources = redisTemplate.opsForHash().multiGet(CACHE_FLAG, list);
        Comparator<Resource> comparator = (r1, r2) -> r2.getParentId().compareTo(r1.getParentId());
        resources.sort(comparator.reversed());
        return resources;
    }

    @Override
    public List<Resource> getByPermissionList(List<String> permissions) {
        PageHelper.orderBy("parent_id asc");
        List<Resource> resources = resourceMapper.selectByPermissionList(permissions);
        return resources;
    }

    @Override
    public void cacheAllResources() {
        Resource resource = new Resource();
        resource.setrStatus(true);
        List<Resource> resources = resourceMapper.select(resource);
        Map<String, Object> resourceMap = new HashMap<>();
        resources.forEach(r -> {
            resourceMap.put(r.getId().toString(), r);
        });
        redisTemplate.opsForHash().putAll(CACHE_FLAG, resourceMap);
    }

    @Override
    public Resource getById(Long id) {
        Resource resource = new Resource();
        resource.setId(id);
        List<Resource> resources = getByResource(resource);
        if (CollectionUtils.isEmpty(resources)) {
            return null;
        }
        return resources.get(0);
    }

    private void cacheReload(List<Resource> resources) {
        Map cacheMap = new HashMap(resources.size());
        resources.forEach(resource -> {
            cacheMap.put(resource.getId().toString(), resource);
        });
        if (!CollectionUtils.isEmpty(resources)) {
            redisTemplate.opsForHash().putAll(CACHE_FLAG, cacheMap);
        }
    }

    private void cacheReloadByIds(List<Long> ids) {
        List<Resource> resources = resourceMapper.selectByIds(ids);
        Map cacheMap = new HashMap();
        resources.forEach(resource -> {
            cacheMap.put(resource.getId().toString(), resource);
        });
        if (!CollectionUtils.isEmpty(resources)) {
            redisTemplate.opsForHash().putAll(CACHE_FLAG, cacheMap);
        }
    }
}
