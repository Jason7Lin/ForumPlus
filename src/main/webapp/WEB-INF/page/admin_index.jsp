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
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="<%=basePath%>/static/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=basePath%>/static/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="<%=basePath%>/static/layui/css/layui.css"/>
</head>

<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo" style="font-size: 17px;"><strong>校园论坛系统管理后台</strong></div>
        <!--导航栏首页-->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item">
                <a href="<%=basePath%>/user/toAdminIndex.do" style="text-decoration: none;">
                    <strong>首页</strong>
                </a>
            </li>
        </ul>

        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;" style="text-decoration: none;">
                    <img src="<%=basePath%>/static/img/avatar.jpg" class="layui-nav-img">
                    <!--用户ID session:userId-->
                    <strong hidden="hidden">${sessionScope.userId}</strong>
                    <!--用户名 session:userName-->
                    <strong>${sessionScope.userName}</strong>
                </a>
                <!--子模块-->
                <dl class="layui-nav-child">
                    <!--个人资料-->
                    <dd>
                        <a href="javascript:;" onclick="javascript: toUserInfo();" style="text-decoration: none;">
                            <strong>基本资料</strong>
                        </a>
                    </dd>
                    <!--安全设置-->
                    <dd><a href="" style="text-decoration: none;"><strong>安全设置</strong></a></dd>
                    <hr/>
                    <!--退出登录-->
                    <dd>
                        <a href="<%=basePath%>/user/outLogin.do" style="text-decoration: none;;">
                            <strong>退出登录</strong>
                        </a>
                    </dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="<%=basePath%>/user/outLogin.do" style="text-decoration: none;;">
                    <strong>退出</strong>
                </a>
            </li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree" lay-filter="test">
                <!--用户管理-->
                <li class="layui-nav-item">
                    <a href="javascript:;" onclick="javascript: toUserManage();" style="text-decoration: none;">
                        <strong>
                            <span class="fa fa-user fa-fw"></span>&nbsp;&nbsp;&nbsp;用户管理
                        </strong>
                    </a>
                </li>
                <!--帖子管理-->
                <li class="layui-nav-item">
                    <a href="javascript:;" onclick="javascript: toArticleManage();" style="text-decoration: none;">
                        <strong>
                            <span class="fa fa-send fa-fw"></span>&nbsp;&nbsp;&nbsp;帖子管理
                        </strong>
                    </a>
                </li>
                <!--版块管理-->
                <li class="layui-nav-item">
                    <a href="javascript:;" onclick="javascript: toModuleManage();" style="text-decoration: none;">
                        <strong>
                            <span class="fa fa-send fa-fw"></span>&nbsp;&nbsp;&nbsp;版块管理
                        </strong>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <!-- 以上都是共享内容 -->

    <!-- 内容主体区域 -->
    <div class="layui-body">
        <div id="content">
            <div style="font-size: 45px;color: #1D9D73;margin-top: 300px;" class="text-center">
                <strong>欢迎您进入校园论坛系统管理后台</strong></div>
        </div>
    </div>

</div>
</body>

<script src="<%=basePath%>/static/js/jquery-3.3.1.min.js"></script>
<script src="<%=basePath%>/static/layui/layui.js"></script>
<script src="<%=basePath%>/static/js/bootstrap.min.js"></script>

<script type="text/javascript">
    layui.use('element', function () {
        var element = layui.element;
    });
</script>
<script type="text/javascript">
    //跳转用户个人资料
    function toUserInfo() {
        document.getElementById("content").innerHTML = "<object type=\"text/html\" data=\"<%=basePath%>/user/toUserInfo.do\" width=\"100%\" height=\"100%\"></object>";
    }

    //跳转用户管理
    function toUserManage() {
        document.getElementById("content").innerHTML = "<object type=\"text/html\" data=\"<%=basePath%>/user/toUserManage.do\" width=\"100%\" height=\"100%\"></object>";
    }

    //跳转帖子管理
    function toArticleManage() {
        document.getElementById("content").innerHTML = "<object type=\"text/html\" data=\"<%=basePath%>/article/toArticleManage.do\" width=\"100%\" height=\"100%\"></object>";
    }

    //跳转模块管理
    function toModuleManage() {
        document.getElementById("content").innerHTML = "<object type=\"text/html\" data=\"<%=basePath%>/module/toModuleManage.do\" width=\"100%\" height=\"100%\"></object>";
    }
</script>
</html>