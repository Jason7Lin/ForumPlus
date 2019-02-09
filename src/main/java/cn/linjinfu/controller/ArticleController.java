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
    Integer signId = 0;

    //多条件分页查询
    @RequestMapping(value = "/findByPage.do")
    public String findByPage(Article article, HttpSession session, HttpServletRequest request, Model model,
                             @RequestParam(value = "pageCode", required = false, defaultValue = "1") int pageCode,
                             @RequestParam(value = "pageSize", required = false, defaultValue = "20") int pageSize) {

        switch (signId) {
            case 1:
                //只适用于String类型
                //保存名字
                String userName = request.getParameter("userName");
                if (userName != null) {
                    session.setAttribute("author", userName);
                } else {
                    userName = (String) session.getAttribute("author");
                }
                article.setUserName(userName);

                //保存标题
                String title = request.getParameter("title");
                if (title != null) {
                    session.setAttribute("title", title);
                } else {
                    title = (String) session.getAttribute("title");
                }
                article.setTitle(title);

                //保存精品
                String great = request.getParameter("great");
                if (great != null) {
                    session.setAttribute("great", great);
                } else {
                    great = (String) session.getAttribute("great");
                }
                article.setGreat(great);

                //搜索数据回显
                model.addAttribute("article", article);
                //多条件分页数据
                PageBean page = articleService.findByPage(article, pageCode, pageSize);
                model.addAttribute("page", page);
                //单选框数据
                List<Module> moduleList = moduleService.seleteModule();
                model.addAttribute("moduleList", moduleList);

                return "page/article/allArticle";
            default:
                return null;
        }
    }

    //1.跳转全部帖子
    @RequestMapping(value = "/toAllArticle.do")
    public String toAllArticle(HttpSession session) {
        signId = 1;
        session.removeAttribute("author");
        session.removeAttribute("title");
        session.removeAttribute("great");
        return "redirect:findByPage.do";
    }


}
