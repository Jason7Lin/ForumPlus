package cn.linjinfu.service;

import cn.linjinfu.mapper.ArticleMapper;
import cn.linjinfu.pojo.Article;
import cn.linjinfu.pojo.PageBean;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ArticleServiceImpl implements ArticleService{

    @Autowired
    private ArticleMapper articleMapper;

    //多条件分页查询
    @Override
    public PageBean<Article> findByPage(Article article, int pageCode, int pageSize) {
        //使用倒序
        String orderBy = "id" + " desc";
        //使用Mybatis分页插件
        PageHelper.startPage(pageCode, pageSize, orderBy);

        //调用分页查询方法，其实就是查询所有数据，mybatis自动帮我们进行分页计算
        //PageHelper插件的page类
        Page<Article> page = articleMapper.findByPage(article);

        //返回封装好的PageBean
        return new PageBean<Article>(pageCode, (int) Math.ceil((double) (page.getTotal() / (double) pageSize)), (int) page.getTotal(), pageSize, page.getResult());
    }
}
