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
    Integer allId = 0;

    //多条件分页查询
    @RequestMapping(value = "/findByPage.do")
    public String findByPage(Article article, HttpSession session, HttpServletRequest request, Model model,
                             @RequestParam(value = "pageCode", required = false, defaultValue = "1") int pageCode,
                             @RequestParam(value = "pageSize", required = false, defaultValue = "20") int pageSize) {

        switch (signId) {
            case 1:
                //保存名字,标题,精品,版块
                /*
                适用于String类型
                 */
                String userName = request.getParameter("userName");
                //点击查询： 1.''(被sql过滤) 2.正常数据
                if (userName != null) {
                    session.setAttribute("author", userName);
                }
                //点击：1.全部帖子首页/底部页码session=null 2.底部页码(使用过查询后)session=前session
                else {
                    userName = (String) session.getAttribute("author");
                }
                article.setUserName(userName);

                String title = request.getParameter("title");
                if (title != null) {
                    session.setAttribute("title", title);
                } else {
                    title = (String) session.getAttribute("title");
                }
                article.setTitle(title);

                String great = request.getParameter("great");
                if (great != null) {
                    session.setAttribute("great", great);
                } else {
                    great = (String) session.getAttribute("great");
                }
                article.setGreat(great);

               /*
                适用于Integer类型,区别Integer.parseInt(!null,!'')
                 */
                String moduleId = request.getParameter("moduleId");
                //点击查询： 1.0(被sql过滤) 2.正常数据
                if (moduleId != null) {
                    session.setAttribute("moduleId", moduleId);
                    article.setModuleId(Integer.parseInt(moduleId));
                }
                //点击：1.全部帖子首页/底部页码session=null 2.底部页码(使用过查询后)session=前session
                else {
                    moduleId= (String) session.getAttribute("moduleId");
                    if (moduleId==null) {
                        article.setModuleId(null);
                    } else {
                        article.setModuleId(Integer.parseInt(moduleId));
                    }
                }

                //搜索数据回显
                model.addAttribute("article", article);
                //多条件分页数据
                PageBean page = articleService.findByPage(article, pageCode, pageSize);
                model.addAttribute("page", page);
                //单选框数据
                List<Module> moduleList = moduleService.seleteModule();
                model.addAttribute("moduleList", moduleList);
                //去所有帖子
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
        session.removeAttribute("moduleId");

        return "redirect:findByPage.do";
    }


}
