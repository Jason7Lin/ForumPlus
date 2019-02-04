package cn.linjinfu.controller;

import cn.linjinfu.pojo.Module;
import cn.linjinfu.pojo.User;
import cn.linjinfu.service.ModuleService;
import cn.linjinfu.service.UserService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping(value = "/user")
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private ModuleService moduleService;

    //返回系统登录首页
    @RequestMapping(value = "/index.do")
    public String index() {
        return "index";
    }

    //用户登录
    @RequestMapping(value = "/login.do")
    public String login(String name, String password, Model model, HttpSession session) {
        //根据用户名查询
        User user = userService.selectUserByName(name);
        //非空
        if (user != null) {
            if (user.getPassword().equals(password)) {
                //保存userId userName
                session.setAttribute("userId", user.getId());
                session.setAttribute("userName", user.getName());
                //是用户
                if (user.getUserAdmin().equals(1)) {
                    //是黑名单
                    if (user.getBlacklist().equals(1)) {
                        model.addAttribute("message", "您的账号已被禁用，请联系管理员");
                        //登录提示页面
                        return "page/message/login_message";
                    }
                    //是白名单
                    if (user.getBlacklist().equals(2)) {
                        //查询所有版块
                        List<Module> moduleList = moduleService.seleteModule();
                        //版块数据
                        model.addAttribute("moduleList", moduleList);
                        //用户首页
                        return "page/user_index";
                    }
                }
                //是管理员
                if (user.getUserAdmin().equals(2)) {
                    //管理员首页
                    return "page/admin_index";
                }
                //异常
                else {
                    return null;
                }
            }
            //用户名或密码错误
            else {
                model.addAttribute("message", "用户名或密码错误");
                //登录提示页面
                return "page/message/login_message";
            }
        }
        //没有此账号
        else {
            model.addAttribute("message", "登录失败");
            //登录提示页面
            return "page/message/login_message";
        }
    }

    //用户注册
    @RequestMapping(value = "/register.do")
    public String register(User user, HttpSession session,Model model) {
        //新增用户
        userService.insertUser(user);
        //保存userId userName
        session.setAttribute("userId", user.getId());
        session.setAttribute("userName", user.getName());
        //是用户
        if (user.getUserAdmin().equals(1)) {
            //查询所有版块
            List<Module> moduleList = moduleService.seleteModule();
            //版块数据
            model.addAttribute("moduleList", moduleList);
            //用户首页
            return "page/user_index";
        }
        //是管理员
        if (user.getUserAdmin().equals(2)) {
            //管理员首页
            return "page/admin_index";
        }
        //异常
        else {
            return null;
        }
    }

    //根据用户名查询（检测用户名是否已经存在）
    @ResponseBody
    @RequestMapping(value = "/checkName.do")
    public String checkName(@RequestBody User user) {
        User info = userService.checkUserByName(user.getName());
        System.out.println(JSONObject.toJSONString(info));
        return JSONObject.toJSONString(info);
    }
}
