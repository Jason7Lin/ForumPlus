package cn.linjinfu.service;

import cn.linjinfu.mapper.UserMapper;
import cn.linjinfu.pojo.User;
import cn.linjinfu.pojo.UserExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    //根据用户名查询
    @Override
    public User selectUserByName(String name) {
        UserExample userExample=new UserExample();
        userExample.createCriteria().andNameEqualTo(name);
        List<User> userList = userMapper.selectByExample(userExample);
        return userList.get(0);
    }

    //新增用户
    @Override
    public void insertUser(User user) {
        userMapper.insertSelective(user);
    }

    //根据用户名查询
    @Override
    public User checkUserByName(String name) {
        User user=userMapper.checkUserByName(name);
        return user;
    }
}
