package com.yz.shiro.api.service;

import com.yz.shiro.entity.App;
import java.util.List;

/**
 * 
* @ClassName: AppService 
* @Description: 应用
* @author yangzhao
* @date 2017年12月20日 下午2:03:43
*
 */
public interface AppService {


    public App createApp(App app);

    public App updateApp(App app);

    public void deleteApp(Long appId);

    /**
     * 根据appKey查找AppId
     * @param appKey
     * @return
     */
    public Long findAppIdByAppKey(String appKey);

    public List<App> getByApp(App app);

    public App getById(Long id);

    /**
     * 获取app列表信息
     * @param ids
     * @return
     */
    public List<App> getByIdList(List<Long> ids);
}
