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
            <strong>我发布的帖子</strong></legend>
    </fieldset>

    <div class="layui-inline" style="margin-left:450px;padding-left: 0;">
        <a href="<%=basePath%>/userArticle/toArticleWrite.do">
            <button type="button" id="addBtn" class="layui-btn layui-btn">新增帖子</button>
        </a>
    </div>
    <hr style="margin-top: 0;"/>

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
                        <%--<td>${article.r_id}</td>--%>
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
                        <a href="<%=basePath%>/userArticle/toEditPage.do?r_id=${article.r_id}">
                            <button type="button" class="layui-btn layui-btn-sm layui-btn-normal">编辑</button>
                        </a>
                        <%--删除2<button type="button" onclick="return clean(${article.r_id});"--%>
                                <%--class="layui-btn layui-btn-sm layui-btn-danger">--%>
                            <%--删除--%>
                        <%--</button>--%>
                        <a data-toggle="modal" data-target="#trashModal">
                            <button type="button" onclick="return trash(${article.r_id})"
                                    class="layui-btn layui-btn-sm layui-btn-danger">
                                删除
                            </button>
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <form class="listForm" method="post" action="<%=basePath%>/userArticle/findByPage.do">
        <div class="row">
            <div class="form-inline">
                <label style="font-size:14px;margin-top:22px;">
                    <strong>共<b>${requestScope.page.totalCount}</b>条记录，共<b>${requestScope.page.totalPage}</b>页</strong>
                    &nbsp;
                    &nbsp;
                    <strong>每页显示</strong>
                    <input name="pageCode" value="${requestScope.page.pageCode}" hidden="hidden"/>
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
                    <strong>到第</strong>&nbsp;<input type="text" size="3" id="page" name="pageCode"
                                                    class="form-control input-sm"
                                                    style="width:11%"/>&nbsp;<strong>页</strong>
                    &nbsp;
                    <button type="submit" class="btn btn-sm btn-info">GO!</button>
                </label>

                <ul class="pagination" style="float:right;">
                    <li>
                        <a href="<%=basePath%>/userArticle/findByPage.do?pageCode=1"><strong>首页</strong></a>
                    </li>
                    <li>
                        <c:if test="${requestScope.page.pageCode > 2}">
                            <a href="<%=basePath%>/userArticle/findByPage.do?pageCode=${requestScope.page.pageCode - 1}">&laquo;</a>
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
                                <a href="<%=basePath%>/userArticle/findByPage.do?pageCode=${i}&pageSize=${requestScope.page.pageSize}">${i}</a>
                            </li>
                        </c:if>
                    </c:forEach>

                    <li>
                        <c:if test="${requestScope.page.pageCode < requestScope.page.totalPage}">
                            <a href="<%=basePath%>/userArticle/findByPage.do?pageCode=${requestScope.page.pageCode + 1}">&raquo;</a>
                        </c:if>
                    </li>
                    <li>
                        <a href="<%=basePath%>/userArticle/findByPage.do?pageCode=${requestScope.page.totalPage}"><strong>末页</strong></a>
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
                    url: '<%=basePath%>/userArticle/deleteArticle.do',
                    type: 'POST',
                    data: {r_id: r_id},
                    success: function (data) {
                        $("html").html(data);
                    },
                    error: function () {
                        alert("错误");
                    }
                });
            });
        }
    }

    //删除2
    function clean(r_id) {
        layer.open({
            title: '警告信息',
            content: '你确定要删除？',
            btn: ['确定', '取消'],
            btn1: function (index, layero) {
                $.ajax({
                    url: '<%=basePath%>/userArticle/deleteArticle.do',
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

    <!-------noUsed-------->
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
