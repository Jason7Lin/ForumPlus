package cn.linjinfu.controller;

import cn.linjinfu.pojo.Article;
import cn.linjinfu.pojo.Module;
import cn.linjinfu.pojo.PageBean;
import cn.linjinfu.service.ArticleService;
import cn.linjinfu.service.ModuleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping(value = "/article")
public class ArticleController {
    @Autowired
    private ArticleService articleService;

    @Autowired
    private ModuleService moduleService;

    //侧栏选择识别码
    Integer signId=0;

    //多条件分页查询
    @RequestMapping(value = "/findByPage.do")
    public String findByPage(Article article, HttpSession session, HttpServletRequest request, Model model,
                             @RequestParam(value = "pageCode", required = false, defaultValue = "1") int pageCode,
                             @RequestParam(value = "pageSize", required = false, defaultValue = "20") int pageSize) {


        if (signId == 1) {
            String userName=request.getParameter("userName");
            if (userName != null) {
                session.setAttribute("userName", userName);
            } else {
                userName = (String) session.getAttribute("userName");
            }
            article.setUserName(userName);
            //回显
            model.addAttribute("article", article);
            //调用findByPage
            PageBean page = articleService.findByPage(article, pageCode, pageSize);
            model.addAttribute("page", page);

            List<Module> moduleList = moduleService.seleteModule();
            model.addAttribute("moduleList",moduleList);
            return "page/article/allArticle";
        } else {
            return null;
        }

    }

    //1.跳转全部帖子
    @RequestMapping(value = "/toAllArticle.do")
    public String toAllArticle() {
        signId = 1;
        return "redirect:findByPage.do";
    }


}
