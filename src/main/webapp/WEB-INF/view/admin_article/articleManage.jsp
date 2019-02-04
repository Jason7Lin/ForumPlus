<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="<%=basePath%>/static/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%=basePath%>/static/css/bootstrap.min.css"/>
</head>
<body>
<div class="container" style="width: 90%;">
    <br/>
    <br/>
    <fieldset class="layui-elem-field layui-field-title">
        <legend style="margin-left: 20px;padding: 0 10px;text-align: left;width: 170px;border-bottom: none;">
            <strong>帖子管理</strong></legend>
    </fieldset>

    <!--新增专属管理员精品贴 按钮-->
    <hr style="margin-top: 0;"/>
    <br/>
    <h5 style="margin-top: -20px;">
        <i class="fa fa-paper-plane-o fa-fw" style="color: #299A74"></i>
        <span style="color: #299A74;"><strong>新增专属管理员精品贴</strong></span>
    </h5>
    <div class="layui-inline" style="margin-left:350px;padding-left: 0;">
        <a href="<%=basePath%>/adminArticle/toArticleWrite.do">
            <button type="button" id="addBtn" class="layui-btn layui-btn">新增帖子
            </button>
        </a>
    </div>
    <br/>
    <br/>
    <br/>

    <!--搜索贴子 表单-->
    <hr style="margin-top: 0;"/>
    <br/>
    <h5 style="margin-top: -20px;">
        <i class="fa fa-paper-plane-o fa-fw" style="color: #299A74"></i>
        <span style="color: #299A74;"><strong>搜索帖子</strong></span>
    </h5>
    <div class="form table">
        <div>
            <form class="layui-form form-inline" action="<%=basePath%>/adminArticle/findByPage.do" role="form"
                  method="post">
                <div class="layui-form-item">
                    <label class="layui-form-label"
                           style="margin-left: -10px;padding-left:0;"><strong>楼主</strong></label>
                    <div class="layui-input-inline" style="width: 150px">
                        <input name="r_author" value="${article.r_author}" placeholder="请输入楼主名字查询" class="layui-input"
                               type="text">
                    </div>

                    <label class="layui-form-label"
                           style="margin-left: -10px;padding-left:0;"><strong>简介</strong></label>
                    <div class="layui-input-inline" style="width: 150px">
                        <input name="r_summary" value="${article.r_summary}" placeholder="请输入帖子简介查询" class="layui-input"
                               type="text">
                    </div>

                    <label class="layui-form-label"
                           style="margin-left: -10px;padding-left:0;"><strong>版块</strong></label>
                    <div class="layui-input-inline" style="width: 100px">
                        <select name="r_module" id="r_module" lay-verify="required" lay-search="">
                            <option value="">请选择</option>
                            <c:forEach items="${moduleList}" var="module">
                                <option value="${module.m_module}"
                                        <c:if test="${module.m_module == article.r_module}">selected</c:if> >${module.m_module}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <label class="layui-form-label"
                           style="margin-left: -10px;padding-left:0;"><strong>精品
                    </strong></label>
                    <div class="layui-input-inline" style="width: 100px">
                        <select name="r_status" id="r_status" lay-verify="required" lay- search="">
                            <option value="">请选择</option>
                            <option value="1"
                                    <c:if test="${'1' == article.r_status}">selected</c:if> >精品
                            </option>
                            <option value="2"
                                    <c:if test="${'2' == article.r_status}">selected</c:if> >非精品
                            </option>
                        </select>
                    </div>
                </div>
                <br/>
                <div class="layui-input-inline" style="margin-left: 350px;">
                    <button class="layui-btn" type="submit">查询</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </form>
        </div>
    </div>
    <br/>

    <!--遍历page.beanList帖子搜索结果-->
    <hr style="margin-top: 0;"/>
    <h5>
        <i class="fa fa-paper-plane-o fa-fw" style="color: #299A74"></i>
        <span style="color: #299A74;"><strong>搜索结果</strong></span>
    </h5>
    <div class="table-responsive">
        <table class="table table-striped table-hover" id="countTable">
            <thead>
            <tr>
                <th style="text-align:center;">精品&nbsp;&nbsp;<i class="layui-icon"
                                                                style="font-size: 18px; color: #2aa198;">&#xe658;</i>
                </th>
                <th style="text-align:center;">所属版块</th>
                <th style="text-align: center">帖子简介</th>
                <th style="text-align: center">帖子楼主</th>
                <th style="text-align: center">发表日期</th>
                <th style="text-align: center;">操作</th>
            </tr>
            </thead>
            <tbody style="text-align: center">
            <c:forEach items="${requestScope.page.beanList}" var="article">
                <tr>
                    <c:if test="${article.r_status=='1'}">
                        <td><i class="layui-icon" style="font-size: 18px; color: #2aa198;">&#xe658;</i></td>
                    </c:if>
                    <c:if test="${article.r_status=='2'}">
                        <td><i class="layui-icon" style="font-size: 18px; color: #2aa198;">&#xe600;</i></td>
                    </c:if>
                    <td>${article.r_module}</td>
                    <td>${article.r_summary}</td>
                    <td>${article.r_author}</td>
                    <td>${article.r_date}</td>
                    <td>
                        <a href="<%=basePath%>/adminArticle/toArticleView.do?r_id=${article.r_id}">
                            <button type="button" class="layui-btn layui-btn-sm">查看</button>
                        </a>
                        <a href="<%=basePath%>/adminArticle/toEditPage.do?r_id=${article.r_id}">
                            <button type="button" class="layui-btn layui-btn-sm layui-btn-normal">编辑</button>
                        </a>
                        <a data-toggle="modal" data-target="#trashModal">
                            <button type="button" onclick="return trash(${article.r_id})"
                                    class="layui-btn layui-btn-sm layui-btn-danger">
                                删除
                            </button>
                        </a>
                        <c:if test="${article.r_status=='1'}">
                            <a href="<%=basePath%>/adminArticle/updateArticleToNormalById.do?r_id=${article.r_id}">
                                <button type="button" class="layui-btn layui-btn-sm">去精品</button>
                            </a>
                        </c:if>
                        <c:if test="${article.r_status=='2'}">
                            <a href="<%=basePath%>/adminArticle/updateArticleToGreatById.do?r_id=${article.r_id}">
                                <button type="button" class="layui-btn layui-btn-sm layui-btn-warm">加精品</button>
                            </a>
                        </c:if>
                        <!--hidden-->
                        <button hidden type="button" onclick="return clean(${article.r_id});" class="layui-btn layui-btn-sm layui-btn-danger">
                            删除2
                        </button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <form class="listForm" method="post"
          action="<%=basePath%>/adminArticle/findByPage.do?r_author=${article.r_author}&r_summary=${article.r_summary}&r_module=${article.r_module}&r_status=${article.r_status}">
        <div class="row">
            <div class="form-inline">
                <label style="font-size:14px;margin-top:22px;">
                    <strong>共<b>${requestScope.page.totalCount}</b>条记录，共<b>${requestScope.page.totalPage}</b>页</strong>
                    &nbsp;
                    &nbsp;
                    <!--Size与搜索表单不匹配，只使用于总体数据-->
                    <strong>每页显示</strong>
                    <%--<input name="pageCode" value="${requestScope.page.pageCode}" hidden="hidden"/>--%>
                    <select class="form-control" name="pageSize">
                        <option value="5"
                                <c:if test="${requestScope.page.pageSize == 5}">selected</c:if> >5
                        </option>
                        <option value="10"
                                <c:if test="${requestScope.page.pageSize == 10}">selected</c:if> >10
                        </option>
                        <option value="15"
                                <c:if test="${requestScope.page.pageSize == 15}">selected</c:if> >15
                        </option>
                        <option value="20"
                                <c:if test="${requestScope.page.pageSize == 20}">selected</c:if> >20
                        </option>
                    </select>
                    <strong>条</strong>
                    &nbsp;
                    &nbsp;
                    <!--无效-->
                    <strong>到第</strong>&nbsp;
                    <input type="text" size="3" id="page" name="pageCode" value="${requestScope.page.pageCode}"
                           class="form-control input-sm"
                           style="width:11%"/>
                    &nbsp;<strong>页</strong>&nbsp;
                    <button type="submit" class="btn btn-sm btn-info">GO!</button>
                </label>

                <ul class="pagination" style="float:right;">
                    <li>
                        <a href="<%=basePath%>/adminArticle/findByPage.do?pageCode=1&r_author=${article.r_author}&r_summary=${article.r_summary}&r_module=${article.r_module}&r_status=${article.r_status}"><strong>首页</strong></a>
                    </li>
                    <li>
                        <c:if test="${requestScope.page.pageCode > 2}">
                            <a href="<%=basePath%>/adminArticle/findByPage.do?pageCode=${requestScope.page.pageCode - 1}&r_author=${article.r_author}&r_summary=${article.r_summary}&r_module=${article.r_module}&r_status=${article.r_status}">&laquo;</a>
                        </c:if>
                    </li>

                    <!-- 写关于分页页码的逻辑 -->
                    <c:choose>
                        <c:when test="${requestScope.page.totalPage <= 5}">
                            <c:set var="begin" value="1"/>
                            <c:set var="end" value="${requestScope.page.totalPage}"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="begin" value="${requestScope.page.pageCode - 1}"/>
                            <c:set var="end" value="${requestScope.page.pageCode + 3}"/>

                            <!-- 头溢出 -->
                            <c:if test="${begin < 1}">
                                <c:set var="begin" value="1"/>
                                <c:set var="end" value="5"/>
                            </c:if>

                            <!-- 尾溢出 -->
                            <c:if test="${end > requestScope.page.totalPage}">
                                <c:set var="begin" value="${requestScope.page.totalPage -4}"/>
                                <c:set var="end" value="${requestScope.page.totalPage}"/>
                            </c:if>
                        </c:otherwise>
                    </c:choose>

                    <!-- 显示页码 -->
                    <c:forEach var="i" begin="${begin}" end="${end}">
                        <!-- 判断是否是当前页 -->
                        <c:if test="${i == requestScope.page.pageCode}">
                            <li class="active"><a href="javascript:void(0);">${i}</a></li>
                        </c:if>
                        <c:if test="${i != requestScope.page.pageCode}">
                            <li>
                                <a href="<%=basePath%>/adminArticle/findByPage.do?pageCode=${i}&pageSize=${requestScope.page.pageSize}&r_author=${article.r_author}&r_summary=${article.r_summary}&r_module=${article.r_module}&r_status=${article.r_status}">${i}</a>
                            </li>
                        </c:if>
                    </c:forEach>

                    <li>
                        <c:if test="${requestScope.page.pageCode < requestScope.page.totalPage}">
                            <a href="<%=basePath%>/adminArticle/findByPage.do?pageCode=${requestScope.page.pageCode + 1}&r_author=${article.r_author}&r_summary=${article.r_summary}&r_module=${article.r_module}&r_status=${article.r_status}">&raquo;</a>
                        </c:if>
                    </li>
                    <li>
                        <a href="<%=basePath%>/adminArticle/findByPage.do?pageCode=${requestScope.page.totalPage}&r_author=${article.r_author}&r_summary=${article.r_summary}&r_module=${article.r_module}&r_status=${article.r_status}"><strong>末页</strong></a>
                    </li>
                </ul>
            </div>
        </div>
    </form>

    <!-- 删除的模态框 删除1 -->
    <div class="modal fade" id="trashModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <!-- 模糊框头部 -->
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;
                    </button>
                    <h4 class="modal-title">警告！</h4>
                </div>
                <!-- 模糊框主体 -->
                <div class="modal-body">
                    <strong>你确定要删除吗？</strong>
                </div>
                <!-- 模糊框底部 -->
                <div class="modal-footer">
                    <button type="button" class="delSure btn btn-info" data-dismiss="modal">确定</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>

</div>

</body>
<script src="<%=basePath%>/static/js/jquery-3.3.1.min.js"></script>
<script src="<%=basePath%>/static/layui/layui.all.js"></script>
<script src="<%=basePath%>/static/js/bootstrap.min.js"></script>
<script type="text/javascript">
    layui.use('element', function () {
        var element = layui.element;
    });
</script>
<script type="text/javascript">

    // 删除1
    function trash(r_id) {
        if (!r_id) {
            alert("error");
        } else {
            $(".delSure").click(function () {
                $.ajax({
                    url: '<%=basePath%>/adminArticle/deleteArticle.do',
                    type: 'POST',
                    data: {r_id: r_id},
                    success: function (data) {
                        $("html").html(data);
                    }
                });
            });
        }
    }

</script>
</html>
