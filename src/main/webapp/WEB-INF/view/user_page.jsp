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
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item">
                <a href="<%=basePath%>/admin/userPage.do" style="text-decoration: none;">
                    <strong>首页</strong>
                </a>
            </li>
        </ul>


        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;" style="text-decoration: none;">
                    <img src="<%=basePath%>/static/img/avatar.jpg" class="layui-nav-img">
                    <strong>${sessionScope.name}</strong>
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:;" onclick="javascript: toUserInfo();"
                           style="text-decoration: none;"><strong>基本资料</strong></a></dd>
                    <dd><a href="" style="text-decoration: none;"><strong>安全设置</strong></a></dd>
                    <hr/>
                    <dd>
                        <a href="<%=basePath%>/admin/outLogin.do" style="text-decoration: none;;">
                            <strong>退出登录</strong>
                        </a>
                    </dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="<%=basePath%>/admin/outLogin.do" style="text-decoration: none;;">
                    <strong>退出</strong>
                </a>
            </li>
        </ul>
    </div>


    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree" lay-filter="test">

                <li class="layui-nav-item">
                    <a href="javascript:;" onclick="javascript: toAllArticle();" style="text-decoration: none;">
                        <strong>
                            <span class="fa fa-twitter fa-fw"></span>&nbsp;&nbsp;&nbsp;全部帖子
                        </strong>
                    </a>
                </li>
                <li class="layui-nav-item">
                    <a style="text-decoration: none;"><strong><span class="fa fa-leaf fa-fw"></span>&nbsp;&nbsp;&nbsp;论坛版块</strong></a>
                    <c:forEach items="${moduleList}" var="module">
                        <dl class="layui-nav-child">
                            <dd>
                                <%--不要传字符串--%>
                                <a href="javascript:;" onclick="javascript: toModuleArticle(${module.m_id});" style="text-decoration: none;">
                                    <strong>${module.m_module}</strong>
                                </a>
                            </dd>
                        </dl>
                    </c:forEach>

                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;" onclick="javascript: toGreatArticle();" style="text-decoration: none;">
                        <strong>
                            <span class="fa fa-send fa-fw"></span>&nbsp;&nbsp;&nbsp;精品帖子
                        </strong>
                    </a>
                </li>
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
    function toUserInfo() {
        document.getElementById("content").innerHTML = "<object type=\"text/html\" data=\"<%=basePath%>/admin/findUserInfo.do?a_name=${sessionScope.name}\" width=\"100%\" height=\"100%\"></object>";
    }

    function toAllArticle() {
        document.getElementById("content").innerHTML = "<object type=\"text/html\" data=\"<%=basePath%>/userArticle/findByPage.do?key=0\" width=\"100%\" height=\"100%\"></object>";
    }

    function toMyArticle() {
        document.getElementById("content").innerHTML = "<object type=\"text/html\" data=\"<%=basePath%>/userArticle/findByPage.do?author=${sessionScope.name}&key=1\" width=\"100%\" height=\"100%\"></object>";
    }

    function toGreatArticle() {
        document.getElementById("content").innerHTML = "<object type=\"text/html\" data=\"<%=basePath%>/userArticle/findByPage.do?status=1&key=3\" width=\"100%\" height=\"100%\"></object>";
    }

    function toModuleArticle(module_id) {


        document.getElementById("content").innerHTML = "<object type=\"text/html\" data=\"<%=basePath%>/userArticle/toModuleArticle.do?module_id=" + module_id + "&key=2\" width=\"100%\" height=\"100%\"></object>";
    }


</script>
</html>