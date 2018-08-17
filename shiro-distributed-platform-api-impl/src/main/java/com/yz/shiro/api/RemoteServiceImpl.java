package com.yz.shiro.api;

import com.yz.shiro.api.remote.PermissionContext;
import com.yz.shiro.api.remote.RemoteService;
import com.yz.shiro.entity.*;
import com.yz.shiro.api.service.*;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.SessionDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.io.Serializable;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 
* @ClassName: RemoteServiceImpl
* @Description: TODO(这里用一句话描述这个类的作用) 
* @author yangyw(imalex@163.com)
* @date 2015年3月20日 下午2:02:05 
*
 */
public class RemoteServiceImpl implements RemoteService {

    @Autowired
    private AuthorizationService authorizationService;

    @Autowired
    private SessionDAO sessionDAO;

    @Resource
    private AppService appServiceImpl;

    @Resource
    private OrganizationService organizationServiceImpl;

    @Resource
    private AreaService areaServiceImpl;

    @Resource
    AreaTypeDicService areaTypeDicServiceImpl;

    @Override
    public Session getSession(String appKey, Serializable sessionId) {
        Session session = sessionDAO.readSession(sessionId);
        return session;
    }

    @Override
    public Serializable createSession(Session session) {
        Serializable serializable = sessionDAO.create(session);
        return serializable;
    }

    @Override
    public void updateSession(String appKey, Session session) {
        sessionDAO.update(session);
    }

    @Override
    public void deleteSession(String appKey, Session session) {
        sessionDAO.delete(session);
    }

    @Override
    public PermissionContext getPermissions(String appKey, String username) {
        PermissionContext permissionContext = new PermissionContext();
        permissionContext.setRoles(authorizationService.findRoles(appKey, username));
        permissionContext.setPermissions(authorizationService.findPermissions(appKey, username));
        return permissionContext;
    }

    @Override
    public List<App> getAppList(Long userId) {
        Authorization authorization = new Authorization();
        authorization.setUserId(userId);
        List<Authorization> authorizations = authorizationService.getByAuthorization(authorization);
        if (CollectionUtils.isEmpty(authorizations)){
            return Collections.EMPTY_LIST;
        }
        List<Long> appIds = authorizations.stream().map(Authorization::getAppId).collect(Collectors.toList());
        List<App> apps = appServiceImpl.getByIdList(appIds);
        return apps;
    }

    @Override
    public Organization getOrganizationById(Long id) {
        Organization organization = new Organization();
        organization.setId(id);
        List<Organization> organizationList = organizationServiceImpl.getByOrganization(organization);
        if (CollectionUtils.isEmpty(organizationList)){
            return null;
        }
        return organizationList.get(0);
    }

    @Override
    public List<Area> getAreaListByIdList(List<Long> idList) {
        List<Area> areas = areaServiceImpl.selectListByIdList(idList);
        return areas;
    }

    @Override
    public List<AreaTypeDic> getAreaTypeDic() {
        List<AreaTypeDic> areaTypeDics = areaTypeDicServiceImpl.selectList(new AreaTypeDic());
        return areaTypeDics;
    }
}
