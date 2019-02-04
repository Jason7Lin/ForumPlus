<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%--
  Created by IntelliJ IDEA.
  User: my-deepin
  Date: 18-4-30
  Time: 上午9:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
    Date date = new Date();
    String nowDate = sdf.format(date);

    Integer count=0;
%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="<%=basePath%>/static/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%=basePath%>/static/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=basePath%>/static/editormd/editormd.min.css"/>
</head>

<body>
<div class="container" style="width:80%;">

    <br/>
    <br/>
    <!-- 文章标题概要 -->
    <h3>
        <center>『 ${article.r_summary} 』</center>
    </h3>
    <br/>
    <!-- 添加Markdown的容器 -->
    <div id="content">
        <textarea>${article.r_content}</textarea>
    </div>
    <div style="border-left: 3px solid #f44336;">
        <div style="margin-bottom:8px;">
            &nbsp;&nbsp;<span style="font-size:15px;">帖子楼主：&nbsp;</span>
            <a href="<%=basePath%>/admin/findOtherUserInfo.do?a_name=${article.r_author}"><span style="font-size:18px;">${article.r_author}</span></a>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size:15px;">所属模块：&nbsp;</span>
            <span style="font-size:15px;">${article.r_module}</span>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size:15px;">发表时间：&nbsp;</span>
            <span style="font-size:15px;">${article.r_date}</span>
        </div>
    </div>
    <hr style="height: 3px;border: none;background-color: #ff0000;background-image: repeating-linear-gradient(-45deg, #fff, #fff 4px, transparent 4px, transparent 8px);"/>

    <!-- 留言的表单 -->
    <div>
        <br/>
        <form class="layui-form" action="<%=basePath%>/userArticle/saveArticleWords.do" method="post">
            <input name="lw_name" id="lw_name" value="${sessionScope.name}" hidden="hidden"/>
            <input name="lw_date" id="lw_date" value="<%=nowDate%>" hidden="hidden"/>
            <input name="lw_for_name" id="lw_for_name" value="${article.r_author}" hidden="hidden"/>
            <input name="lw_for_article_id" id="lw_for_article_id" value="${article.r_id}" hidden="hidden"/>
            <div class="layui-input-block" style="margin-left: 0;">
                <textarea id="lw_content" name="lw_content" placeholder="请输入你的留言" class="layui-textarea"
                          style="height: 150px;"></textarea>
            </div>
            <br/>
            <div class="layui-input-block" style="text-align: left;margin-left: 0;">
                <input type="submit" class="layui-btn" value="留言">
            </div>
        </form>

        <br/>
    </div>

    <!-- 留言信息列表展示 遍历留言信息-->
    <c:forEach items="${requestScope.wordsList}" var="words" varStatus="status">
        <c:if test="${words.lw_for_article_id eq article.r_id}">
            <%
                count++;
            %>

            <hr style="height: 3px;border: none;background-color: #00a8c6;background-image: repeating-linear-gradient(-45deg, #fff, #fff 4px, transparent 4px, transparent 8px);"/>
            <div>
                <h5><%=count%>楼</h5>
            </div>
            <br/>
            <div>
                <h4>${words.lw_content}</h4>
            </div>
            <br/>
            <div style="border-left: 3px solid #f44336;">
                <div style="margin-bottom:8px;">
                    &nbsp;&nbsp;<span style="font-size:15px;">留言用户：&nbsp;</span>
                    <a href="<%=basePath%>/admin/findOtherUserInfo.do?a_name=${words.lw_name}"><span style="font-size:18px;">${words.lw_name}</span></a>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size:15px;">留言时间：&nbsp;</span>
                    <span style="font-size:15px;">${words.lw_date}</span>
                </div>
            </div>
            <form hidden action="<%=basePath%>/userArticle/deleteArticleWords.do?lw_id=${words.lw_id}&r_id=${article.r_id}"
                  method="post">
                <input type="submit" class="layui-btn layui-btn-danger" value="删除"></input>
            </form>
        </c:if>
    </c:forEach>

</div>
</body>

<script src="<%=basePath%>/static/js/jquery-3.3.1.min.js"></script>
<script src="<%=basePath%>/static/layui/layui.all.js"></script>
<script src="<%=basePath%>/static/js/bootstrap.min.js"></script>

<!-- Markdwon富文本 -->v
<script src="<%=basePath%>/static/editormd/lib/marked.min.js"></script>
<script src="<%=basePath%>/static/editormd/lib/prettify.min.js"></script>
<script src="<%=basePath%>/static/editormd/lib/raphael.min.js"></script>
<script src="<%=basePath%>/static/editormd/lib/underscore.min.js"></script>
<script src="<%=basePath%>/static/editormd/lib/sequence-diagram.min.js"></script>
<script src="<%=basePath%>/static/editormd/lib/flowchart.min.js"></script>
<script src="<%=basePath%>/static/editormd/lib/jquery.flowchart.min.js"></script>
<script src="<%=basePath%>/static/editormd/editormd.min.js"></script>

<script type="text/javascript">
    layui.use('element', function () {
        var element = layui.element;
    });
</script>

<script type="text/javascript">

    //Markdown富文本
    var markdown;
    $(function () {
        markdown = editormd.markdownToHTML('content', {
            htmlDecode: "style,script,iframe",
            syncScrolling: 'single',
            emoji: true,
            taskList: true,
            tex: true,
            flowChart: true,
            sequenceDiagram: true,
            codeFold: true
        });
    });

</script>
</html>
