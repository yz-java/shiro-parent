package com.yz.shiro.api.impl;

import com.github.pagehelper.PageHelper;
import com.yz.shiro.dao.OrganizationMapper;
import com.yz.shiro.entity.Organization;
import com.yz.shiro.api.service.BaseServiceManager;
import com.yz.shiro.api.service.OrganizationService;
import org.springframework.aop.framework.AopContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.util.CollectionUtils;
import java.util.*;

/**
 * @Description: 组织
 * @ClassName: OrganizationServiceImpl
 * @author yangzhao
 * @date 2017年12月20日 下午2:04:44
 */
@Service
public class OrganizationServiceImpl extends BaseServiceManager<Organization,OrganizationMapper> implements OrganizationService {

    @Autowired
    private OrganizationMapper organizationMapper;

    @Override
    @Autowired
    public void setDao(OrganizationMapper organizationMapper) {
        this.dao = organizationMapper;
    }

    @Override
    public List<Organization> selectPageList(Organization organization, int pageIndex, int pageSize) {
        return null;
    }

    @Override
    public Organization createOrganization(Organization organization) {
        organizationMapper.insertSelective(organization);
        return organization;
    }

    @Override
    public boolean updateOrganization(Organization organization) {
        Organization source = findOne(organization.getId());
        boolean b = organizationMapper.updateByPrimaryKeySelective(organization);
        if (!b) {
            return b;
        }

        List<Organization> organizations = organizationMapper.selectByParentId(source.getId());

        if (CollectionUtils.isEmpty(organizations)) {
            return b;
        }

        Organization target = findOne(organization.getParentId());
        OrganizationService organizationService = (OrganizationService) AopContext.currentProxy();
        boolean move = organizationService.move(source, target);
        if (!move) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return false;
        }
        return true;
    }

    @Override
    public void deleteOrganization(Long id) {
        organizationMapper.deleteByPrimaryKey(id);
    }

    @Override
    public Organization findOne(Long organizationId) {
        Organization organization = organizationMapper.selectByPrimaryKey(organizationId);
        return organization;
    }

    @Override
    public List<Organization> findAll() {
        PageHelper.orderBy("createtime asc");
        List<Organization> organizations = organizationMapper.select(new Organization());
        return organizations;
    }

    @Override
    public List<Organization> findAllWithExclude(Organization excludeOraganization) {
        Map params = new HashMap();
        params.put("id", excludeOraganization.getId());
        params.put("parentIds", excludeOraganization.getParentIds() + excludeOraganization.getId());
        List<Organization> organizations = organizationMapper.selectAllWithExclude(params);
        return organizations;
    }

    @Override
    public boolean move(Organization source, Organization target) {

        Map<String, Object> mapOne = new HashMap<String, Object>();
        mapOne.put("parentId", target.getId());
        mapOne.put("parentIds", target.getParentIds() + target.getId() + "/");
        mapOne.put("id", source.getId());
        boolean b = organizationMapper.elementMoveById(mapOne);

        if (!b) {
            return b;
        }

        Map<String, Object> mapTwo = new HashMap<String, Object>();
        String targetParentIds = target.getParentIds() + target.getId() + "/" + source.getId();
        mapTwo.put("targetParentIds", targetParentIds);
        mapTwo.put("sourceParentIds", source.getParentIds() + source.getId() + "/");
        b = organizationMapper.nodeMove(mapTwo);
        if (!b) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
        }
        return b;

    }

    @Override
    public List<Organization> getByParentId(Long parentId) {
        List<Organization> organizations = organizationMapper.selectByParentId(parentId);
        return organizations;
    }

    @Override
    public List<Organization> getByOrganization(Organization organization) {
        PageHelper.orderBy("parent_id asc");
        List<Organization> organizations = organizationMapper.select(organization);
        return organizations;
    }

    @Override
    public boolean updateOrgStatus(Long organizationId, boolean status, int childStatus) {
        Organization organization = new Organization();
        organization.setId(organizationId);
        organization.setOrgStatus(status);
        organization.setUpdatetime(new Date());
        boolean b = organizationMapper.updateByPrimaryKeySelective(organization);
        if (!b) {
            return false;
        }
        if (childStatus == -1) {
            return true;
        }
        organization = organizationMapper.selectByPrimaryKey(organizationId);
        Map params = new HashMap(3);
        params.put("orgStatus", childStatus);
        params.put("parentIds", organization.getParentIds());
        params.put("updatetime", new Date());
        b = organizationMapper.updateAllChildStatusByParentIds(params);
        if (!b) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
        }
        return true;
    }
}
