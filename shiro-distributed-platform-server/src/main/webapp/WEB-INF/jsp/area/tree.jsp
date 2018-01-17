<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@include file="../main.jsp" %>
    <link href="https://cdn.bootcss.com/zTree.v3/3.5.29/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/zTree.v3/3.5.29/js/jquery.ztree.all.min.js"></script>
    <script type="application/javascript">
        $(function () {
            var setting = {
                data: {
                    simpleData: {
                        enable: true
                    }
                },
                callback: {
                    onClick: function (event, treeId, treeNode) {
                        <%--parent.frames['content'].location.href = "${pageContext.request.contextPath}/organization/" + treeNode.id + "/maintain";--%>
                    }
                }
            };

            var zNodes = [
                <c:forEach items="${areas}" var="area">
                {id:${area.id}, pId:${area.parentId}, name: "${area.aName}", open: true},
                </c:forEach>
            ];

            $(document).ready(function () {
                $.fn.zTree.init($("#tree"), setting, zNodes);
            });
        })
    </script>
</head>
<body>
<div class="container-fluid" style="margin: 0;padding: 0">
    <div class="text-center panel panel-default">
        <div class="panel-heading" style="position: relative">
            <span>区域结构</span>
            <a href="/area/tree" style="position: absolute;right: 15px;top: 13px">
                <span class="glyphicon glyphicon-refresh"></span>
            </a>
        </div>
        <div class="panel-body">
            <ul id="tree" class="ztree"></ul>
        </div>

    </div>
</div>
</body>
</html>