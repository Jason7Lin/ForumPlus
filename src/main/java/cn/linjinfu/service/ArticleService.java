package cn.linjinfu.service;

import cn.linjinfu.pojo.Article;
import cn.linjinfu.pojo.PageBean;

public interface ArticleService {
    //多条件分页查询
    PageBean<Article> findByPage(Article article, int pageCode, int pageSize);
}
