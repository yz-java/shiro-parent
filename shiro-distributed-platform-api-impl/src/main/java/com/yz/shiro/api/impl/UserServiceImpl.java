package com.yz.shiro.api.impl;


import com.yz.shiro.dao.UserMapper;
import com.yz.shiro.entity.User;
import com.yz.shiro.api.service.UserService;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.List;

/**
 * 
* @ClassName: UserServiceImpl 
* @Description: 用户
* @author yangyw(imalex@163.com)
* @date 2015年3月20日 下午2:06:47 
*
 */
@Service
public class UserServiceImpl implements UserService {

    @Resource
    private UserMapper userMapper;

    @Resource
    private PasswordHelper passwordHelper;

    @Resource
    private RedisTemplate redisTemplate;

    /**
     * 创建用户
     * @param user
     */
    @Override
    public User createUser(User user) {
        //加密密码
        passwordHelper.encryptPassword(user);
        userMapper.insert(user);
        return user;
    }

    @Override
    public User updateUser(User user) {
        User u = userMapper.selectByPrimaryKey(user.getId());
        if (u==null){
            return u;
        }
        boolean update = userMapper.updateByPrimaryKeySelective(user);
        if (update){
            Long delete = redisTemplate.opsForHash().delete("user", u.getUsername());
            if (delete<1){
                redisTemplate.opsForHash().delete("user", u.getUsername());
            }
        }
        return user;
    }

    @Override
    public boolean deleteUser(Long userId) {
    	return userMapper.deleteByPrimaryKey(userId);
    }

    /**
     * 修改密码
     * @param userId
     * @param newPassword
     */
    @Override
    public void changePassword(Long userId, String newPassword) {
    	
        User user =userMapper.selectByPrimaryKey(userId);
        user.setPassword(newPassword);
        passwordHelper.encryptPassword(user);
        userMapper.updateByPrimaryKeySelective(user);
    }

    @Override
    public User findOne(Long userId) {
    	
        return userMapper.selectByPrimaryKey(userId);
    }

    @Override
    public List<User> findAll() {
        return userMapper.select(new User());
    }

    /**
     * 根据用户名查找用�?
     * @param username
     * @return
     */
    @Override
    public User findByUsername(String username) {
        User user = (User) redisTemplate.opsForHash().get("user", username);
        if (user!=null){
            return user;
        }
        user = new User();
        user.setUsername(username);
        List<User> users = userMapper.select(user);
        if (CollectionUtils.isEmpty(users)){
            return null;
        }
        redisTemplate.opsForHash().put("user",username,users.get(0));
        return users.get(0);
    }

    @Override
    public List<User> getByUser(User user) {
        List<User> users = userMapper.select(user);
        return users;
    }
}
