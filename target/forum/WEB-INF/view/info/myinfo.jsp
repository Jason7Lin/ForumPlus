<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                <c:if test="${user.a_photo==null }">
                    <img class="img-thumbnail"
                         style="position: relative; width: 140px; height: 140px; left: 10px; top: -20px;"
                         src="<%=basePath%>/static/img/avatar.jpg">
                </c:if>
                <c:if test="${user.a_photo!=null }">
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
                <b style="font-size: 25px;">${user.a_name }</b> &nbsp;&nbsp;&nbsp;
            </div>
        </div>
        <br>
        <!--性别-->
        <div class="row">
            <div class="col-md-12">
                <b>性别</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <c:if test="${ user.a_sex == null}">
                    <span>NULL</span>
                </c:if>
                <c:if test="${ user.a_sex != null}">
                    <span>${ user.a_sex }</span>
                </c:if>
            </div>
        </div>
        <br>
        <!--年龄-->
        <div class="row">
            <div class="col-md-12">
                <b>年龄</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <c:if test="${ user.a_age == null}">
                    <span>NULL</span>
                </c:if>
                <c:if test="${ user.a_age != null}">
                    <span>${ user.a_age }</span>
                </c:if>
            </div>
        </div>
        <br>
        <!--联系电话-->
        <div class="row">
            <div class="col-md-12">
                <b>联系电话</b> &nbsp;&nbsp;&nbsp;
                <c:if test="${ user.a_telephone == null}">
                    <span>NULL</span>
                </c:if>
                <c:if test="${ user.a_telephone != null}">
                    <span>${ user.a_telephone }</span>
                </c:if>
            </div>
        </div>
        <br>
        <!--电子邮箱-->
        <div class="row">
            <div class="col-md-12">
                <b>电子邮箱</b> &nbsp;&nbsp;&nbsp;
                <c:if test="${ user.a_email == null}">
                    <span>NULL</span>
                </c:if>
                <c:if test="${ user.a_email != null}">
                    <span>${ user.a_email }</span>
                </c:if>
            </div>
        </div>
        <br>
        <!--个人简介-->
        <div class="row">
            <div class="col-md-12">
                <b>个人简介</b> &nbsp;&nbsp;&nbsp;
                <c:if test="${ user.a_sign == null}">
                    <span>NULL</span>
                </c:if>
                <c:if test="${ user.a_sign != null}">
                    <span>${ user.a_sign }</span>
                </c:if>
            </div>
        </div>
        <br>
        <!--注册日期-->
        <div class="row">
            <div class="col-md-12">
                <b>注册日期</b> &nbsp;&nbsp;&nbsp; <span>${user.a_date }</span>
            </div>
        </div>
        <br>
        <!--身份-->
        <div class="row">
            <div class="col-md-12">
                <b>身份</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <c:if test="${ user.a_key == 0}">
                    <span>普通用户</span>
                </c:if>
                <c:if test="${ user.a_key == 1}">
                    <span>管理员</span>
                </c:if>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-md-2">
                <button type="button" class="btn btn-info" onclick="return edit(${user.a_id})">
                    编辑个人资料
                </button>
            </div>
        </div>
        <br>
    </div>

    <!-- 编辑的模态框 -->
    <form id="form_edit" class="form-horizontal" role="form" method="post"
          action="<%=basePath%>/admin/updateUserById.do">
        <div id="editModal" class="modal fade" role="dialog" aria-labelledby="myModalLabel"
             aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">编辑个人信息</h4>
                    </div>
                    <div class="modal-body" style="margin-left: 80px;">
                        <input name="a_id" id="a_id" hidden="hidden"/>
                        <input name="a_name" id="a_name" hidden="hidden"/>
                        <div class="form-group form-inline">
                            <label>性别：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <select class="form-control" name="a_sex" id="a_sex" lay-verify="required" lay-search="">
                                <option value="">请选择</option>
                                <option value="男" selected>男</option>
                                <option value="女">女</option>
                            </select>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group form-inline">
                            <label>年龄：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <input type="text" name="a_age" class="form-control" id="a_age"/>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group form-inline">
                            <label>电话号码：</label>
                            <input type="text" name="a_telephone" class="form-control" id="a_telephone"/>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group form-inline">
                            <label>电子邮箱：</label>
                            <input type="text" name="a_email" class="form-control" id="a_email"/>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group form-inline">
                            <label>个人简介：</label>
                            <%--<input type="text" name="a_sign" class="form-control" id="a_sign"/>--%>
                            <textarea style="width: 400px; height: 150px" name="a_sign" class="form-control"
                                      id="a_sign"></textarea>
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
    // 编辑信息的方法
    function edit(a_id) {
        if (!a_id) {
            alert("error");
        } else {
            // 先去查询数据
            $.ajax({
                url: '<%=basePath%>/admin/findUserById.do',
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json;charset=UTF-8',
                data: JSON.stringify({
                    a_id: a_id
                }),
                success: function (data) {
                    $("#a_id").val(data.a_id);
                    $("#a_name").val(data.a_name);
                    $("#a_sex").val(data.a_sex);
                    $("#a_age").val(data.a_age);
                    $("#a_telephone").val(data.a_telephone);
                    $("#a_email").val(data.a_email);
                    $("#a_sign").val(data.a_sign);
                    $("#editModal").modal('show');
                },
                error: function () {
                    alert("错误");
                }
            });
        }
    }

    //提交表单的方法
    $(".editSure").click(function () {
        $("#form_edit").submit();
    });

</script>
</html>