package com.yz.shiro.dao;

import com.yz.shiro.entity.User;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserMapper {
    boolean deleteByPrimaryKey(Long id);

    boolean insert(User record);

    boolean insertSelective(User record);

    User selectByPrimaryKey(Long id);

    boolean updateByPrimaryKeySelective(User record);

    boolean updateByPrimaryKey(User record);

    List<User> select(User user);
}