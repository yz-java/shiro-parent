package com.yz.shiro.api.remote;

import com.yz.shiro.api.entity.App;
import com.yz.shiro.api.entity.Area;
import com.yz.shiro.api.entity.AreaTypeDic;
import com.yz.shiro.api.entity.Organization;
import org.apache.shiro.session.Session;

import java.io.Serializable;
import java.util.List;

public interface RemoteService
{
  public Session getSession(String paramString, Serializable paramSerializable);

  public Serializable createSession(Session paramSession);

  public void updateSession(String paramString, Session paramSession);

  public void deleteSession(String paramString, Session paramSession);

  /**
   * 获取用户角色和权限列表
   * @param appKey 应用key
   * @param username 用户名
   * @return
   */
  public PermissionContext getPermissions(String appKey, String username);

  /**
   * 获取APP列表
   * @param userId
   * @return
   */
  public List<App> getAppList(Long userId);

  /**
   * 获取组织机构信息
   * @param id
   * @return
   */
  public Organization getOrganizationById(Long id);

  /**
   * 获取区域信息
   * @param idList
   * @return
   */
  public List<Area> getAreaListByIdList(List<Long> idList);

  /**
   * 获取所有区域类型字典列表
   * @return
   */
  public List<AreaTypeDic> getAreaTypeDic();
}
