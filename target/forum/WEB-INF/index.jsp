<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    Date date = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String nowDate = sdf.format(date);
%>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Title</title>
    <link rel="stylesheet" href="<%=basePath%>/static/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=basePath%>/static/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="<%=basePath%>/static/layui/css/layui.css"/>
    <style type="text/css">
        .header {
            background-image: url("<%=basePath%>/static/img/color.jpeg");
            background-size: 100%;
            height: 240px;
        }

        #code {
            font-family: Arial;
            font-style: italic;
            font-weight: bold;
            letter-spacing: 2px;
            color: #393D49;
            width: 70px;
        }

        #content {
            width: 40%;
            margin: 6% 30% 0 30%;
            height: 53%;
        }

    </style>
</head>

<body>
<div class="header">
    <div style="margin: 0 45% 0 45%;padding-top:5%;text-align:center;">
        <div style="height:16%;width:90%;background:black;text-align:center;">
            <h3 style="font-family: Menlo;color:white;padding-top:5%;"><strong>BBS</strong></h3>
        </div>
    </div>
</div>

<div class="container">
    <div id="content">
        <h2 class="text-nowrap" style="color: #393D49;text-align:center;padding-top:10%;font-family: Menlo">校园论坛系统</h2>

        <!--选择表头-->
        <div style="text-align: center;">
            <br/>
            <br/>
            <!--选择登录-->
            <label style="font-size:20px;color:white;padding-right:8%;">
                <a href="#" id="login" style="text-decoration: none;border-bottom:2px solid #009688;color:#009688">登录</a>
            </label>
            <!--选择注册-->
            <label style="font-size:20px;color:white;padding-left:8%;">
                <a href="#" id="register" style="text-decoration:none;">注册</a>
            </label>
        </div>
        <hr style="color: #484848;text-align:center;"/>

        <!-- 登录的表单 -->
        <form action="<%=basePath%>/user/login.do" id="loginform" method="post" class="layui-form" style="text-align: center;margin-right:12%;margin-top:10%;">
            <div>
                <!--输入用户名-->
                <div class="layui-form-item layui-inline" style="width:110%">
                    <label class="layui-form-label" style="margin-left:13%;">
                        <i class="fa fa-user fa-fw"></i>
                    </label>
                    <div class="layui-input-inline">
                        <input type="text" name="name" class="layui-input" style="background:none;border: none;border-bottom:1px solid white;" placeholder="用户名"/>
                    </div>
                </div>
                <br/>
                <!--输入密码-->
                <div class="layui-form-item layui-inline">
                    <label class="layui-form-label">
                        <span class="fa fa-lock fa-fw"></span>
                    </label>
                    <div class="layui-input-inline">
                        <input type="password" name="password" class="layui-input" style="background:none;border: none;border-bottom:1px solid white;" placeholder="密码"/>
                    </div>
                </div>
                <br/>
                <br/>
                <!--登录按钮-->
                <div style="text-align:center;color: #009688;background-color: #01AAED;width:48%;margin-left:138px;">
                    <input type="submit" class="layui-btn layui-btn-lg" style="background: none;" value="登录"/>
                </div>
            </div>
        </form>

        <!-- 注册的表单 -->
        <form action="<%=basePath%>/user/register.do" id="registerform" method="post" class="layui-form" hidden="hidden" style="text-align: center;margin-right:12%;margin-top:10%;">
            <div>
                <!--隐藏的默认白名单-->
                <input type="text" name="blacklist" value="2" id="blacklist" hidden="hidden"/>
                <!--隐藏的实时注册时间-->
                <input type="text" name="date" value="<%=date%>" id="date" hidden="hidden"/>
                <!--输入用户名-->
                <div class="layui-form-item layui-inline" style="width:110%">
                    <label class="layui-form-label" style="margin-left:13%;">
                        <i class="fa fa-user fa-fw"></i>
                    </label>
                    <div class="layui-input-inline">
                        <input type="text" name="name" id="name" onblur="return checkName();" class="layui-input" style="background:none;border: none;border-bottom:1px solid white;" placeholder="用户名"/>
                    </div>
                    <!--提示信息-->
                    <span id="info"></span>
                </div>
                <br/>
                <!--输入密码-->
                <div class="layui-form-item layui-inline">
                    <label class="layui-form-label" style="font-size:16px;">
                        <span class="fa fa-lock fa-fw"></span>
                    </label>
                    <div class="layui-input-inline">
                        <input type="password" name="password" id="password" class="layui-input" style="background:none;border: none;border-bottom:1px solid white;" placeholder="密码"/>
                    </div>
                </div>
                <br/>
                <!--选择身份-->
                <div class="layui-form-item layui-inline" style="width:110%">
                    <label class="layui-form-label" style="margin-left:13%;">
                        <i class="fa fa-battery fa-fw"></i>
                    </label>
                    <div class="layui-input-block" style="width:50%">
                        <input type="radio" name="userAdmin" value="1" title="用户" checked="">
                        <input type="radio" name="userAdmin" value="2" title="管理员">
                    </div>
                </div>
                <br/>
                <!--验证码-->
                <div class="layui-form-item layui-inline" style="margin-left: 14%;">
                    <label class="layui-form-label">
                        <span class="fa fa-envelope fa-fw"></span>
                    </label>
                    <div class="layui-input-inline" style="width: 32%;">
                        <input type="text" id="check" class="layui-input" style="background:none;border: none;border-bottom:1px solid white;"/>
                    </div>
                    <div class="layui-input-inline">
                        <input type="button" id="code" onclick="createCode()" style="background:none;border: none;margin-left:198px;margin-top:-14%;"/>
                    </div>
                </div>
                <br/>
                <br/>
                <!--注册按钮-->
                <div style="text-align:center;color: #009688;background-color: #01AAED;width:48%;margin-left:34%;">
                    <input type="button" class="layui-btn layui-btn-lg" style="background: none;" value="注册" onclick="validate()"/>
                </div>
            </div>
        </form>
    </div>
</div>
</body>

<script src="<%=basePath%>/static/js/jquery-3.3.1.min.js"></script>
<script src="<%=basePath%>/static/layui/layui.all.js"></script>

<script type="text/javascript">
    layui.use(['layer', 'element'], function () {
        var layer = layui.layer;
        var element = layui.element;
    });
    $("#register").click(function () {
        $("#login").css({'border': 'none', 'color': '#393D49'});
        $(this).css({'border-bottom': '2px solid #009688', 'color': '#009688'});
        $("#loginform").hide();
        $("#registerform").show();
    });
    $("#login").click(function () {
        $("#register").css({'border': 'none', 'color': '#393D49'});
        $(this).css({'border-bottom': '2px solid #009688', 'color': '#009688'});
        $("#registerform").hide();
        $("#loginform").show();
    });

    function checkName() {
        var name = $("#name").val();
        if (name != '') {
            $.ajax({
                url: '<%=basePath%>/user/checkName.do',
                type: 'post',
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                //注意 传对象还是字符串是不同的
                data: JSON.stringify({"name": name}),
                success: function (data) {
                    if (data == null) {
                        $("#info").text("可以注册").css({'color': 'green', 'font-size': '1px'});
                        return true;
                    }
                    if (data != null) {
                        $("#info").text("该用户名已注册").css({'color': 'red', 'font-size': '1px'});
                        return false;
                    }
                },
                error: function () {
                    alert("错误");
                    return false;
                }
            });
        }
        if (name == '') {
            $("#info").text("");
        }
    }
</script>

<script type="text/javascript">
    //设置一个全局的变量，便于保存验证码
    var code;

    function createCode() {
        //首先默认code为空字符串
        code = '';
        //设置长度，这里看需求，我这里设置了4
        var codeLength = 4;
        var codeV = document.getElementById('code');
        //设置随机字符
        var random = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');
        //循环codeLength 我设置的4就是循环4次
        for (var i = 0; i < codeLength; i++) {
            //设置随机数范围,这设置为0 ~ 36
            var index = Math.floor(Math.random() * 36);
            //字符串拼接 将每次随机的字符 进行拼接
            code += random[index];
        }
        //将拼接好的字符串赋值给展示的Value
        codeV.value = code;
    }

    //下面就是判断是否== 的代码，无需解释
    function validate() {
        var oValue = document.getElementById('check').value.toUpperCase();
        if (oValue == 0) {
            layer.open({
                title: '警告信息',
                content: '请输入验证码'
            });
        } else if (oValue != code) {
            $("#check").val("");
            layer.open({
                title: '警告信息',
                content: '您输入的验证码不正确，请重新输入'
            });
            createCode();
        } else if (checkName()) {
            layer.open({
                title: '警告信息',
                content: '您输入的用户名有误，请重新输入'
            });
        } else {
            $("#registerform").submit();
        }
    }

    //设置此处的原因是每次进入界面展示一个随机的验证码，不设置则为空
    window.onload = function () {
        createCode();
    }
</script>

</html>
