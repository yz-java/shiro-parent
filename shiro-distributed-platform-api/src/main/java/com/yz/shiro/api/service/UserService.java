package com.yz.shiro.api.service;


import com.yz.shiro.api.entity.User;

import java.util.List;

/**
 * 
* @ClassName: UserService 
* @Description: 系统用户
* @author yangzhao
* @date 2017年3月20日 下午2:06:30
*
 */
public interface UserService {

    /**
     * 创建用户
     * @param user
     */
    public User createUser(User user);

    public User updateUser(User user);

    public boolean deleteUser(Long userId);

    /**
     * 修改密码
     * @param userId
     * @param newPassword
     */
    public void changePassword(Long userId, String newPassword);


    User findOne(Long userId);

    List<User> findAll();

    /**
     * 根据用户名查找用�?
     * @param username
     * @return
     */
    public User findByUsername(String username);

    /**
     * 获取用户列表
     * @param user
     * @return
     */
    public List<User> getByUser(User user);


}
