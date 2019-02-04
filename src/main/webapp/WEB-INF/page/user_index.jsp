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
        <div class="layui-logo" style="font-size: 17px;"><strong>校园论坛系统</strong></div>
        <!--导航栏首页-->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item">
                <a href="<%=basePath%>/user/toUserIndex.do" style="text-decoration: none;">
                    <strong>首页</strong>
                </a>
            </li>
        </ul>
        <!--个人中心&退出登录-->
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;" style="text-decoration: none;">
                    <!--头像-->
                    <img src="<%=basePath%>/static/img/avatar.jpg" class="layui-nav-img">
                    <!--session:userId-->
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
                <!--全部帖子-->
                <li class="layui-nav-item">
                    <a href="javascript:;" onclick="javascript: toAllArticle();" style="text-decoration: none;">
                        <strong>
                            <span class="fa fa-twitter fa-fw"></span>&nbsp;&nbsp;&nbsp;全部帖子
                        </strong>
                    </a>
                </li>
                <!--论坛版块-->
                <li class="layui-nav-item">
                    <a style="text-decoration: none;"><strong><span class="fa fa-leaf fa-fw"></span>&nbsp;&nbsp;&nbsp;论坛版块</strong></a>
                    <c:forEach items="${moduleList}" var="module">
                        <dl class="layui-nav-child">
                            <dd><%--javascript function(参数不要传字符串）--%>
                                <a href="javascript:;" onclick="javascript: toModuleArticle(${module.id});" style="text-decoration: none;">
                                    <strong>${module.name}</strong>
                                </a>
                            </dd>
                        </dl>
                    </c:forEach>
                </li>
                <!--精品帖子-->
                <li class="layui-nav-item">
                    <a href="javascript:;" onclick="javascript: toGreatArticle();" style="text-decoration: none;">
                        <strong>
                            <span class="fa fa-send fa-fw"></span>&nbsp;&nbsp;&nbsp;精品帖子
                        </strong>
                    </a>
                </li>
                <!--我的帖子-->
                <li class="layui-nav-item">
                    <a href="javascript:;" onclick="javascript: toMyArticle();" style="text-decoration: none;">
                        <strong>
                            <span class="fa fa-user fa-fw"></span>&nbsp;&nbsp;&nbsp;我的帖子
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
                <strong>欢迎您进入校园论坛系统</strong></div>
        </div>
    </div>

</div>
</body>

<script src="<%=basePath%>/static/layui/layui.js"></script>
<script src="<%=basePath%>/static/js/bootstrap.min.js"></script>
<script src="<%=basePath%>/static/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
    layui.use('element', function () {
        var element = layui.element;
    });
</script>
<script type="text/javascript">
    //跳转个人资料
    function toUserInfo() {
        document.getElementById("content").innerHTML = "<object type=\"text/html\" data=\"<%=basePath%>/user/toUserInfo.do\" width=\"100%\" height=\"100%\"></object>";
    }

    //跳转全部帖子 page1
    function toAllArticle() {
        document.getElementById("content").innerHTML = "<object type=\"text/html\" data=\"<%=basePath%>/article/toAllArticle.do\" width=\"100%\" height=\"100%\"></object>";
    }

    //跳转帖子版块 page2
    function toModuleArticle(moduleId) {
        document.getElementById("content").innerHTML = "<object type=\"text/html\" data=\"<%=basePath%>/article/toModuleArticle.do?moduleId=" + moduleId + "\" width=\"100%\" height=\"100%\"></object>";
    }

    //跳转精品帖子 page3
    function toGreatArticle() {
        document.getElementById("content").innerHTML = "<object type=\"text/html\" data=\"<%=basePath%>/article/toGreatArticle.do\" width=\"100%\" height=\"100%\"></object>";
    }

    //跳转我的帖子 page4
    function toMyArticle() {
        document.getElementById("content").innerHTML = "<object type=\"text/html\" data=\"<%=basePath%>/article/toMyArticle.do\" width=\"100%\" height=\"100%\"></object>";
    }
</script>
</html>