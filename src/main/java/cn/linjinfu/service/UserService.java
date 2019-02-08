package cn.linjinfu.service;

import cn.linjinfu.pojo.User;

public interface UserService {
    //根据用户名查询
    User selectUserByName(String name);

    //新增用户
    void insertUser(User user);

    //根据ID查询
    User selectUserById(Integer userId);

    //编辑用户
    void updateUserById(User user);
}
