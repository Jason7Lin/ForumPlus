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
            <strong>浏览帖子</strong></legend>
    </fieldset>
    <br/>

    <h5 style="margin-top: -20px;">
        <i class="fa fa-paper-plane-o fa-fw" style="color: #299A74"></i>
        <span style="color: #299A74;"><strong>搜索帖子</strong></span>
    </h5>
    <hr style="margin-top: 0;"/>

    <div class="form table">
        <div>
            <form class="layui-form form-inline" action="<%=basePath%>/userArticle/findByPage.do" role="form"
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
                    <div class="layui-input-inline" style="margin-left: 350px;">
                        <button class="layui-btn" type="submit">查询</button>
                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <hr style="margin-top: 0;"/>

    <h5>
        <i class="fa fa-paper-plane-o fa-fw" style="color: #299A74"></i>
        <span style="color: #299A74;"><strong>您搜索到的帖子</strong></span>
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
                        <a href="<%=basePath%>/userArticle/toArticleView.do?r_id=${article.r_id}">
                            <button type="button" class="layui-btn layui-btn-sm">查看</button>
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!--一个空格都是致命的，格式化害人啊-->
    <form class="listForm" method="post"
          action="<%=basePath%>/userArticle/findByPage.do?r_author=${article.r_author}&r_summary=${article.r_summary}&r_module=${article.r_module}&r_status=${article.r_status}">
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
                        <a href="<%=basePath%>/userArticle/findByPage.do?pageCode=1&r_author=${article.r_author}&r_summary=${article.r_summary}&r_module=${article.r_module}&r_status=${article.r_status}"><strong>首页</strong></a>
                    </li>
                    <li>
                        <c:if test="${requestScope.page.pageCode > 2}">
                            <a href="<%=basePath%>/userArticle/findByPage.do?pageCode=${requestScope.page.pageCode - 1}&r_author=${article.r_author}&r_summary=${article.r_summary}&r_module=${article.r_module}&r_status=${article.r_status}">&laquo;</a>
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
                                <a href="<%=basePath%>/userArticle/findByPage.do?pageCode=${i}&pageSize=${requestScope.page.pageSize}&r_author=${article.r_author}&r_summary=${article.r_summary}&r_module=${article.r_module}&r_status=${article.r_status}">${i}</a>
                            </li>
                        </c:if>
                    </c:forEach>

                    <li>
                        <c:if test="${requestScope.page.pageCode < requestScope.page.totalPage}">
                            <a href="<%=basePath%>/userArticle/findByPage.do?pageCode=${requestScope.page.pageCode + 1}&r_author=${article.r_author}&r_summary=${article.r_summary}&r_module=${article.r_module}&r_status=${article.r_status}">&raquo;</a>
                        </c:if>
                    </li>
                    <li>
                        <a href="<%=basePath%>/userArticle/findByPage.do?pageCode=${requestScope.page.totalPage}&r_author=${article.r_author}&r_summary=${article.r_summary}&r_module=${article.r_module}&r_status=${article.r_status}"><strong>末页</strong></a>
                    </li>
                </ul>
            </div>
        </div>
    </form>
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
    //删除
    function clean(r_id) {
        layer.open({
            title: '警告信息',
            content: '你确定要删除？（文章将保存在回收站中）',
            btn: ['确定', '取消'],
            btn1: function (index, layero) {
                $.ajax({
                    url: '<%=basePath%>/article/clean.do',
                    type: 'POST',
                    data: {r_id: r_id},
                    success: function (data) {
                        layer.open({
                            title: '提示信息',
                            content: '删除成功',
                            time: 2000
                        });
                        $("body").html(data);
                    },
                    error: function () {
                        layer.open({
                            title: '提示信息',
                            content: '删除失败'
                        });
                    }
                });
                layer.close(index);
            }
        });
    }

    //编辑
    function edit(r_id) {
        $.ajax({
            url: '<%=basePath%>/article/toEditPage.do',
            type: 'GET',
            data: {r_id: r_id},
            success: function (data) {
                $("body").html(data);
            },
            error: function () {
                layer.open({
                    title: '提示信息',
                    content: '发生错误'
                });
            }
        });
    }

    $("#cleanBtnMore").click(function () {
        layer.open({
            title: '警告信息',
            content: '你确定要删除所选文章吗？',
            btn: ['确定', '取消'],
            btn1: function (index, layero) {
                layer.close(index);
            }
        });
    });
    //全选
    var all = $("#all");
    var id = $("#a_id");
    all.onclick = function () {
        for (var i = 0; i < id.length; i++) {
            id[i].checked = all.checked;
        }
    }
</script>

</html>
