package com.yz.shiro.api.service;

import com.yz.shiro.api.entity.Organization;

import java.util.List;

/**
 * 
* @ClassName: OrganizationService 
* @Description: 组织机构
* @author yangzhao
* @date 2017年12月20日 下午2:04:31
*
 */
public interface OrganizationService {


    public Organization createOrganization(Organization organization);

    public boolean updateOrganization(Organization organization);

    public void deleteOrganization(Long organizationId);

    Organization findOne(Long organizationId);

    List<Organization> getByParentId(Long parentId);

    List<Organization> findAll();

    Object findAllWithExclude(Organization excludeOraganization);

    boolean move(Organization source, Organization target);

    List<Organization> getByOrganization(Organization organization);

    /**
     * 修改状态
     * @param organizationId 当前结构ID
     * @param status 当前结构状态
     * @param childStatus 下级状态 -1=忽略
     * @return
     */
    boolean updateOrgStatus(Long organizationId,boolean status,int childStatus);
}
