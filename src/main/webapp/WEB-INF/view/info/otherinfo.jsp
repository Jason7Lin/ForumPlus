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
    </div>

</div>
</body>

</html>