package com.yz.shiro.server.application;

import com.yz.shiro.api.service.ResourceService;
import com.yz.shiro.api.service.RoleService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

import javax.annotation.Resource;

/**
 * @author yangzhao
 * @Description 应用启动预处理
 * @Date create by 11:56 17/12/26
 */
public class ApplicationPrepareHandler implements ApplicationContextAware {

    private final Logger logger = LoggerFactory.getLogger(ApplicationPrepareHandler.class);

    @Resource
    private RoleService roleService;

    @Resource
    private ResourceService resourceService;

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        logger.info("预加载所有角色信息...");
        roleService.cacheReloadAllRoles();
        logger.info("预加载所有资源信息...");
        resourceService.cacheAllResources();
    }
}
