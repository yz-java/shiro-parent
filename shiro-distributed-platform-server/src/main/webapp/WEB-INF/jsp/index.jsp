<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: yangzhao
  Date: 17/12/20
  Time: 17:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="main.jsp"%>
    <title>首页</title>
    <script type="application/javascript">
        $(function () {
            $($("li")[0]).addClass("layui-this");
            $($("li")[0]).click();
        })
        function content(url,e) {
            $.each($("li"),function (i, v) {
                $(v).removeClass("layui-this");
            })
            $(e).addClass("layui-this");
            $("iframe").attr('src',url);
        }
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <ul class="layui-tab-title">
            <c:forEach var="resource" items="${resources}" varStatus="status">
                <c:if test="${resource.rType==0}">
                    <c:forEach items="${resources}" var="r">
                        <c:if test="${r.rType==1 && r.parentId==resource.id}">
                            <c:set var="url" value="${r.url}"/>
                        </c:if>
                    </c:forEach>
                    <li onclick="content('${url}',this);">${resource.rName}</li>
                </c:if>

            </c:forEach>


        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <iframe style="border: 0" width="100%" height="100%" src=""/>
            </div>
        </div>
    </div>
</div>
</body>
</html>
