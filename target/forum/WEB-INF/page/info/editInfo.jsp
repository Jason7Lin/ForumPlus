<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    Date date = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String nowDate = sdf.format(date);
    String name = (String) request.getSession().getAttribute("name");
%>
<html>

<head>
    <title>Title</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="<%=basePath%>/static/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=basePath%>/static/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="<%=basePath%>/static/layui/css/layui.css"/>
</head>

<body>
<div class="container" style="margin-top: 80px">
    <div class="col-md-12 col-xs-12">
        <!--头像-->
        <div class="row">
            <div class="col-md-2">
                <c:if test="${user.photo==null }">
                    <img class="img-thumbnail"
                         style="position: relative; width: 140px; height: 140px; left: 10px; top: -20px;"
                         src="<%=basePath%>/static/img/avatar.jpg">
                </c:if>
                <c:if test="${user.photo!=null }">
                    <img class="img-thumbnail"
                         style="position: relative; width: 140px; height: 140px; left: 10px; top: -20px;"
                        <%--src="${basePath }/static/upload/user/${myListUser.userphoto }">--%>
                         src="<%=basePath%>/static/img/avatar.jpg">
                </c:if>
            </div>
        </div>
        <br>
        <!-- 用户名 -->
        <div class="row">
            <div class="col-md-12">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <b style="font-size: 25px;">${user.name }</b> &nbsp;&nbsp;&nbsp;
            </div>
        </div>
        <br>
        <!--性别-->
        <div class="row">
            <div class="col-md-12">
                <b>性别</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <c:if test="${ user.sex == null}">
                    <span>NULL</span>
                </c:if>
                <c:if test="${ user.sex != null}">
                    <span>${ user.sex }</span>
                </c:if>
            </div>
        </div>
        <br>
        <!--年龄-->
        <div class="row">
            <div class="col-md-12">
                <b>年龄</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <c:if test="${ user.age == null}">
                    <span>NULL</span>
                </c:if>
                <c:if test="${ user.age != null}">
                    <span>${ user.age }</span>
                </c:if>
            </div>
        </div>
        <br>
        <!--联系电话-->
        <div class="row">
            <div class="col-md-12">
                <b>联系电话</b> &nbsp;&nbsp;&nbsp;
                <c:if test="${ user.telephone == null}">
                    <span>NULL</span>
                </c:if>
                <c:if test="${ user.telephone != null}">
                    <span>${ user.telephone }</span>
                </c:if>
            </div>
        </div>
        <br>
        <!--电子邮箱-->
        <div class="row">
            <div class="col-md-12">
                <b>电子邮箱</b> &nbsp;&nbsp;&nbsp;
                <c:if test="${ user.email == null}">
                    <span>NULL</span>
                </c:if>
                <c:if test="${ user.email != null}">
                    <span>${ user.email }</span>
                </c:if>
            </div>
        </div>
        <br>
        <!--个人简介-->
        <div class="row">
            <div class="col-md-12">
                <b>个人简介</b> &nbsp;&nbsp;&nbsp;
                <c:if test="${ user.introduction == null}">
                    <span>NULL</span>
                </c:if>
                <c:if test="${ user.introduction != null}">
                    <span>${ user.introduction }</span>
                </c:if>
            </div>
        </div>
        <br>
        <!--注册日期-->
        <div class="row">
            <div class="col-md-12">
                <b>注册日期</b> &nbsp;&nbsp;&nbsp;
                <span><fmt:formatDate value="${user.date}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
            </div>
        </div>
        <br>
        <!--身份-->
        <div class="row">
            <div class="col-md-12">
                <b>身份</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <c:if test="${ user.userAdmin == 1}">
                    <span>普通用户</span>
                </c:if>
                <c:if test="${ user.userAdmin == 2}">
                    <span>管理员</span>
                </c:if>
            </div>
        </div>
        <br>
        <!--点击编辑按钮-->
        <div class="row">
            <div class="col-md-2">
                <button type="button" class="btn btn-info" onclick="return edit()">
                    编辑个人资料
                </button>
                <%--<button type="button" class="btn btn-info" onclick="return edit(${user.id})">--%>
                <%--编辑个人资料--%>
                <%--</button>--%>
            </div>
        </div>
        <br>
    </div>

    <!-- 编辑的模态框 -->
    <form id="form_edit" class="form-horizontal" role="form" method="post"
          action="<%=basePath%>/user/updateUserById.do">
        <div id="editModal" class="modal fade" role="dialog" aria-labelledby="myModalLabel"
             aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">编辑个人信息</h4>
                    </div>
                    <div class="modal-body" style="margin-left: 80px;">
                        <!--隐藏的ID-->
                        <input type="text" name="id" value="${user.id}" hidden="hidden">
                        <!--编辑性别-->
                        <div class="form-group form-inline">
                            <label>性别：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <select class="form-control" name="sex" id="sex" lay-verify="required" lay-search="">
                                <option value="">请选择</option>
                                <option value="男" <c:if test="${user.sex=='男'}">selected</c:if>>男</option>
                                <option value="女" <c:if test="${user.sex=='女'}">selected</c:if>>女</option>
                            </select>
                        </div>
                        <br/>
                        <br/>
                        <!--编辑年龄-->
                        <div class="form-group form-inline">
                            <label>年龄：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <input type="text" name="age" value="${user.age}" class="form-control" id="age"/>
                        </div>
                        <br/>
                        <br/>
                        <!--编辑电话号码-->
                        <div class="form-group form-inline">
                            <label>电话号码：</label>
                            <input type="text" name="telephone" value="${user.telephone}" class="form-control" id="telephone"/>
                        </div>
                        <br/>
                        <br/>
                        <!--编辑电子邮箱-->
                        <div class="form-group form-inline">
                            <label>电子邮箱：</label>
                            <input type="text" name="email" value="${user.email}" class="form-control" id="email"/>
                        </div>
                        <br/>
                        <br/>
                        <!--编辑个人简历-->
                        <div class="form-group form-inline">
                            <label>个人简介：</label>
                            <textarea style="width: 400px; height: 150px" name="introduction" class="form-control"
                                      id="introduction">${user.introduction}</textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="editSure btn btn-info" data-dismiss="modal">修改</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </div>
        </div>
    </form>

</div>
</body>

<script src="<%=basePath%>/static/js/jquery-3.3.1.min.js"></script>
<script src="<%=basePath%>/static/js/bootstrap.min.js"></script>
<script type="text/javascript">
    // 启用编辑模态框的方法
    function edit() {
        $("#editModal").modal('show');
    }

    //提交编辑表单的方法
    $(".editSure").click(function () {
        $("#form_edit").submit();
    });

    <%--// 编辑信息的方法--%>
    <%--function edit(id) {--%>
    <%--if (!id) {--%>
    <%--alert("error");--%>
    <%--} else {--%>
    <%--// 先去查询数据--%>
    <%--$.ajax({--%>
    <%--url: '<%=basePath%>/admin/findUserById.do',--%>
    <%--type: 'POST',--%>
    <%--dataType: 'json',--%>
    <%--contentType: 'application/json;charset=UTF-8',--%>
    <%--data: JSON.stringify({--%>
    <%--a_id: a_id--%>
    <%--}),--%>
    <%--success: function (data) {--%>
    <%--$("#a_id").val(data.a_id);--%>
    <%--$("#a_name").val(data.a_name);--%>
    <%--$("#a_sex").val(data.a_sex);--%>
    <%--$("#a_age").val(data.a_age);--%>
    <%--$("#a_telephone").val(data.a_telephone);--%>
    <%--$("#a_email").val(data.a_email);--%>
    <%--$("#a_sign").val(data.a_sign);--%>
    <%--$("#editModal").modal('show');--%>
    <%--},--%>
    <%--error: function () {--%>
    <%--alert("错误");--%>
    <%--}--%>
    <%--});--%>
    <%--}--%>
    <%--}--%>
</script>
</html>