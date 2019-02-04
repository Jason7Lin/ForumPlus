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
            <strong>用户管理</strong></legend>
    </fieldset>
    <br/>

    <h5 style="margin-top: -20px;">
        <i class="fa fa-paper-plane-o fa-fw" style="color: #299A74"></i>
        <span style="color: #299A74;"><strong>搜索用户</strong></span>
    </h5>
    <hr style="margin-top: 0;"/>

    <div class="form table">
        <div>
            <form class="layui-form form-inline" action="<%=basePath%>/admin/findByPage.do" role="form"
                  method="post">
                <div class="layui-form-item">
                    <label class="layui-form-label"
                           style="margin-left: -10px;padding-left:0;"><strong>用户</strong></label>
                    <div class="layui-input-inline" style="width: 150px">
                        <input name="a_name" value="${user.a_name}" placeholder="请输入用户名查询" class="layui-input"
                               type="text">
                    </div>

                    <label class="layui-form-label"
                           style="margin-left: -10px;padding-left:0;"><strong>性别</strong></label>
                    <div class="layui-input-inline" style="width: 100px">
                        <select name="a_sex" id="a_sex" lay-verify="required" lay-search="">
                            <option value="">请选择</option>
                            <option value="男"
                                    <c:if test="${'男' == user.a_sex}">selected</c:if> >男
                            </option>
                            <option value="女"
                                    <c:if test="${'女' == user.a_sex}">selected</c:if> >女
                            </option>
                        </select>
                    </div>

                    <label class="layui-form-label"
                           style="margin-left: -10px;padding-left:0;"><strong>年龄</strong></label>
                    <div class="layui-input-inline" style="width: 150px">
                        <input name="a_age" value="${user.a_age}" placeholder="请输入年龄查询" class="layui-input"
                               type="text">
                    </div>

                    <div class="layui-input-inline" style="margin-left: 50px;">
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
        <span style="color: #299A74;"><strong>您搜索到的用户</strong></span>
    </h5>
    <div class="table-responsive">
        <table class="table table-striped table-hover" id="countTable">
            <thead>
            <tr>
                <th style="text-align:center;">用户</th>
                <th style="text-align: center">性别</th>
                <th style="text-align: center">年龄</th>
                <th style="text-align: center">电子邮箱</th>
                <th style="text-align:center;">黑名单&nbsp;&nbsp;
                <th style="text-align: center;">操作</th>
            </tr>
            </thead>
            <tbody style="text-align: center">
            <c:forEach items="${requestScope.page.beanList}" var="user">
                <tr>
                    <td>${user.a_name}</td>
                    <td>${user.a_sex}</td>
                    <td>${user.a_age}</td>
                    <td>${user.a_email}</td>
                    <c:if test="${user.a_black=='1'}">
                        <td><i class="layui-icon" style="font-size: 18px; color: #FD482C;">&#xe612;</i></td>
                    </c:if>
                    <c:if test="${user.a_black=='0'}">
                        <td><i class="layui-icon" style="font-size: 18px; color: #009f95;">&#xe612;</i></td>
                    </c:if>

                    <td>
                        <c:if test="${user.a_black=='1'}">
                            <a href="<%=basePath%>/admin/updateUserToWhiteById.do?a_id=${user.a_id}">
                                <button type="button" class="layui-btn layui-btn-sm">恢复</button>
                            </a>
                        </c:if>
                        <c:if test="${user.a_black=='0'}">
                            <a href="<%=basePath%>/admin/updateUserToBlackById.do?a_id=${user.a_id}">
                                <button type="button" class="layui-btn layui-btn-sm layui-btn-danger">禁用</button>
                            </a>
                        </c:if>

                        <a href="<%=basePath%>/admin/toFindOtherUserInfo.do?a_name=${user.a_name}">
                            <button type="button" class="layui-btn layui-btn-sm layui-btn-normal">查看</button>
                        </a>

                        <a href="<%=basePath%>/adminArticle/findByPage.do?r_author=${user.a_name}">
                            <button type="button" class="layui-btn layui-btn-sm layui-btn-warm">帖子</button>
                        </a>

                        <a  hidden href="<%=basePath%>/admin/toArticleView.do?r_id=${article.r_id}">
                            <button type="button" class="layui-btn layui-btn-sm">留言</button>
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <form class="listForm" method="post" action="<%=basePath%>/admin/findByPage.do?a_name=${user.a_name}&a_sex=${user.a_sex}&a_age=${user.a_age}">
        <div class="row">
            <div class="form-inline">
                <label style="font-size:14px;margin-top:22px;">
                    <strong>共<b>${requestScope.page.totalCount}</b>条记录，共<b>${requestScope.page.totalPage}</b>页</strong>
                    &nbsp;
                    &nbsp;
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
                    <input type="text" size="3" id="page" name="pageCode" value="${requestScope.page.pageCode}" class="form-control input-sm"
                           style="width:11%"/>
                    &nbsp;<strong>页</strong>&nbsp;
                    <button type="submit" class="btn btn-sm btn-info">GO!</button>
                </label>

                <ul class="pagination" style="float:right;">
                    <li>
                        <a href="<%=basePath%>/admin/findByPage.do?pageCode=1&a_name=${user.a_name}&a_sex=${user.a_sex}&a_age=${user.a_age}"><strong>首页</strong></a>
                    </li>
                    <li>
                        <c:if test="${requestScope.page.pageCode > 2}">
                            <a href="<%=basePath%>/admin/findByPage.do?pageCode=${requestScope.page.pageCode - 1}&a_name=${user.a_name}&a_sex=${user.a_sex}&a_age=${user.a_age}">&laquo;</a>
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
                                <a href="<%=basePath%>/admin/findByPage.do?pageCode=${i}&pageSize=${requestScope.page.pageSize}&a_name=${user.a_name}&a_sex=${user.a_sex}&a_age=${user.a_age}">${i}</a>
                            </li>
                        </c:if>
                    </c:forEach>

                    <li>
                        <c:if test="${requestScope.page.pageCode < requestScope.page.totalPage}">
                            <a href="<%=basePath%>/admin/findByPage.do?pageCode=${requestScope.page.pageCode + 1}&a_name=${user.a_name}&a_sex=${user.a_sex}&a_age=${user.a_age}">&raquo;</a>
                        </c:if>
                    </li>
                    <li>
                        <a href="<%=basePath%>/admin/findByPage.do?pageCode=${requestScope.page.totalPage}&a_name=${user.a_name}&a_sex=${user.a_sex}&a_age=${user.a_age}"><strong>末页</strong></a>
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
                    url: '<%=basePath%>/admin/deleteArticle.do',
                    type: 'POST',
                    data: {r_id: r_id},
                    success: function (data) {
                        $("body").html(data);
                    }
                });
            });
        }
    }
</script>

</html>
