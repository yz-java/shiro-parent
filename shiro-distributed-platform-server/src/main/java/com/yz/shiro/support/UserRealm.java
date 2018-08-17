package com.yz.shiro.support;

import com.yz.shiro.entity.User;
import com.yz.shiro.api.service.AuthorizationService;
import com.yz.shiro.api.service.UserService;
import com.yz.shiro.common.constants.Constant;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.support.DefaultSubjectContext;
import org.apache.shiro.util.ByteSource;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.session.mgt.DefaultWebSessionManager;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Collection;
import java.util.Set;

/**
 * @author yangyw(imalex@163.com)
 * @ClassName: UserRealm
 * @Description: 用户权限登录
 * @date 2015年3月20日 下午2:00:32
 */
public class UserRealm extends AuthorizingRealm {

    @Autowired
    private UserService userService;

    @Autowired
    private AuthorizationService authorizationService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        String username = (String) principals.getPrimaryPrincipal();

        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();

        Set<String> roleSet = authorizationService.findRoles(Constant.SERVER_APP_KEY, username);
        authorizationInfo.setRoles(roleSet);
        Set<String> permissionsSet = authorizationService.findPermissions(Constant.SERVER_APP_KEY, username);
        authorizationInfo.setStringPermissions(permissionsSet);
        return authorizationInfo;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) {
        SimpleAuthenticationInfo authenticationInfo = null;
        try {
            String username = (String) token.getPrincipal();

            //同一账户、同一地点只允许一人登录处理
            DefaultWebSecurityManager securityManager = (DefaultWebSecurityManager) SecurityUtils.getSecurityManager();
            DefaultWebSessionManager sessionManager = (DefaultWebSessionManager)securityManager.getSessionManager();
            Collection<Session> sessions = sessionManager.getSessionDAO().getActiveSessions();//获取当前已登录的用户session列表
            for(Session session:sessions){
                //清除该用户以前登录时保存的session
                if(username.equals(String.valueOf(session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY)))) {
                    sessionManager.getSessionDAO().delete(session);
                }
            }

            User user = userService.findByUsername(username);
            if (user == null) {
                throw new UnknownAccountException();//没找到帐号?
            }

            if (Boolean.TRUE.equals(user.getLocked())) {
                throw new LockedAccountException(); //帐号锁定
            }

            //交给AuthenticatingRealm使用CredentialsMatcher进行密码匹配
            authenticationInfo = new SimpleAuthenticationInfo(
                    user.getUsername(),
                    user.getPassword(),
                    ByteSource.Util.bytes(user.getSalt()),//salt=username+salt
                    getName()
            );
            SecurityUtils.getSubject().getSession().setAttribute("UserId", user.getId());
            SecurityUtils.getSubject().getSession().setAttribute("OrgId", user.getOrganizationId());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return authenticationInfo;
    }

    @Override
    public void clearCachedAuthorizationInfo(PrincipalCollection principals) {
        super.clearCachedAuthorizationInfo(principals);
    }

    @Override
    public void clearCachedAuthenticationInfo(PrincipalCollection principals) {
        super.clearCachedAuthenticationInfo(principals);
    }

    @Override
    public void clearCache(PrincipalCollection principals) {
        super.clearCache(principals);
    }

    public void clearAllCachedAuthorizationInfo() {
        getAuthorizationCache().clear();
    }

    public void clearAllCachedAuthenticationInfo() {
        getAuthenticationCache().clear();
    }

    public void clearAllCache() {
        clearAllCachedAuthenticationInfo();
        clearAllCachedAuthorizationInfo();
    }

}
