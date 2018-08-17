package com.yz.shiro.api.impl;

import com.yz.shiro.dao.AppMapper;
import com.yz.shiro.entity.App;
import com.yz.shiro.api.service.AppService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.List;

/**
 * 
* @ClassName: AppServiceImpl 
* @Description: 应用
* @author yangyw(imalex@163.com)
* @date 2015年3月20日 下午2:03:56 
*
 */
@Service
public class AppServiceImpl implements AppService {

    @Autowired
    private AppMapper appMapper;

    @Resource
    private RedisTemplate redisTemplate;

    @Override
    public App createApp(App app) {
        appMapper.insertSelective(app);
        return app;
    }

    @Override
    public App updateApp(App app) {
    	appMapper.updateByPrimaryKeySelective(app);
        return app;
    }

    @Override
    public void deleteApp(Long appId) {
        App app = appMapper.selectByPrimaryKey(appId);
        if (app==null){
            return;
        }
        boolean b = appMapper.deleteByPrimaryKey(appId);
        if (b){
            redisTemplate.opsForValue().set(app.getAppKey(),null);
        }
    }


    @Override
    public Long findAppIdByAppKey(String appKey) {
        Object appid = redisTemplate.opsForValue().get(appKey);
        if (appid!=null){
            return Long.parseLong(appid.toString());
        }
        Long appId = appMapper.selectAppIdByAppKey(appKey);
        redisTemplate.opsForValue().set(appKey,appId);
        return appId;
    }

    @Override
    public List<App> getByApp(App app) {
        List<App> appList = appMapper.select(app);
        return appList;
    }

    @Override
    public App getById(Long id) {
        App app = new App();
        app.setId(id);
        List<App> apps = getByApp(app);
        if (!CollectionUtils.isEmpty(apps)){
            return apps.get(0);
        }
        return null;
    }

    @Override
    public List<App> getByIdList(List<Long> ids) {
        List<App> apps = appMapper.selectByIds(ids);
        return apps;
    }
}
