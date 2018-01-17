package com.yz.shiro.client;

import com.yz.shiro.api.remote.RemoteService;
import com.yz.shiro.common.session.ShiroSession;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.CachingSessionDAO;
import java.io.Serializable;

/**
 *
 * @ClassName: ClientSessionDAO
 * @Description: 客户端Session管理
 * @author yangzhao
 * @date 2017年12月20日 下午2:03:43
 *
 */
public class ClientSessionDAO extends CachingSessionDAO {

    private RemoteService remoteService;

    private String appKey;

    public void setRemoteService(RemoteService remoteService) {
        this.remoteService = remoteService;
    }

    public void setAppKey(String appKey) {
        this.appKey = appKey;
    }

    @Override
    protected void doDelete(Session session) {
        remoteService.deleteSession(appKey, session);
    }

    @Override
    protected void doUpdate(Session session) {
        if (session instanceof ShiroSession){
            ShiroSession shiroSession = (ShiroSession) session;
            if (!shiroSession.isChanged()){
                return;
            }
        }
        remoteService.updateSession(appKey, session);
    }


    @Override
    protected Serializable doCreate(Session session) {
        Serializable sessionId = remoteService.createSession(session);
        assignSessionId(session, sessionId);
        return sessionId;
    }

    @Override
    protected Session doReadSession(Serializable sessionId) {
        return remoteService.getSession(appKey, sessionId);
    }
}
