package com.yz.shiro.common.session;

import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.SessionContext;
import org.apache.shiro.session.mgt.SessionFactory;

/**
 * @author yangzhao
 * @Description
 * @Date create by 18:57 18/1/4
 */
public class ShiroSessionFactory implements SessionFactory {
    @Override
    public Session createSession(SessionContext sessionContext) {
        if(sessionContext != null) {
            String host = sessionContext.getHost();
            if(host != null) {
                return new ShiroSession(host);
            }
        }

        return new ShiroSession();
    }
}
