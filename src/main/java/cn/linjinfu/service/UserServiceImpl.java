package cn.linjinfu.service;

import cn.linjinfu.mapper.UserMapper;
import cn.linjinfu.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    //新增用户
    @Override
    public void insertUser(User user) {
        userMapper.insertSelective(user);
    }

    //根据ID查询
    @Override
    public User selectUserById(Integer userId) {
        return userMapper.selectByPrimaryKey(userId);
    }

    //编辑用户
    @Override
    public void updateUserById(User user) {
        userMapper.updateByPrimaryKeySelective(user);
    }

    //根据用户名查询（检测用户名是否已经存在）
    @Override
    public User selectUserByName(String name) {
        User user = userMapper.selectUserByName(name);
        return user;
    }
}
