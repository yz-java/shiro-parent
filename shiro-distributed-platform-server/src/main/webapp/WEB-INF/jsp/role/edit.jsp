<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: yangzhao
  Date: 17/12/19
  Time: 17:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="../main.jsp" %>
    <title>角色编辑</title>
    <link href="https://cdn.bootcss.com/zTree.v3/3.5.29/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/zTree.v3/3.5.29/js/jquery.ztree.all.min.js"></script>
    <script type="application/javascript">
        layui.use('form', function () {
            var form = layui.form;
        })
        $(function () {
            var setting = {
                data: {
                    simpleData: {
                        enable: true
                    }
                },
                callback: {
                    onClick: function (event, treeId, treeNode) {

                        var html = $("#add_permission").html();
                        console.log(html)
                        html += '<span id="' + treeNode.id + '" onclick="$(this).remove();"><input type="checkbox" class="form-control" checked="checked" title="' + treeNode.name + '" name="permission" value="' + treeNode.id + '"/>';
                        html += '<div class="layui-unselect layui-form-checkbox layui-form-checked" lay-skin=""><span>' + treeNode.name + '</span><i class="layui-icon"></i></div></span>';
                        $("#add_permission").html(html);
                    }
                }
            };

            var zNodes = [
                <c:forEach items="${resources}" var="resource" varStatus="s">
                    <c:if test="${s.count==1}">
                        {id:${resource.id}, pId:${resource.parentId}, name: "${resource.rName}", open: true},
                    </c:if>
                    <c:if test="${s.count!=1}">
                        {id:${resource.id}, pId:${resource.parentId}, name: "${resource.rName}", open: true},
                    </c:if>
                </c:forEach>
            ];

            $(document).ready(function () {
                $.fn.zTree.init($("#tree"), setting, zNodes);
            });
        })

        function add() {
            $("form").attr('action', '/role/create');
            $("form").submit();
        }
        function edit() {
            $("form").attr('action', '/role/update');
            $("form").submit();
        }
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="col-xs-3 panel panel-default" style="margin: 0;padding: 0">
        <div class="panel-heading" style="position: relative">
            <span>资源结构</span>
        </div>
        <div class="panel-body">
            <ul id="tree" class="ztree"></ul>
        </div>
    </div>
    <div class="col-xs-9 text-center">
        <h1>
            <c:if test="${option=='add'}">
                角色添加
            </c:if>
            <c:if test="${option=='edit'}">
                角色编辑
            </c:if>
        </h1>
        <form class="form-horizontal layui-form layui-form-pane1 text-center" method="post" role="form">
            <div class="form-group">
                <label for="rCode" class="col-sm-3 control-label">编码:</label>
                <div class="col-sm-2">
                    <input type="text" class="form-control" name="rCode" id="rCode" value="${role.rCode}">
                </div>
            </div>
            <div class="form-group">
                <label for="rDesc" class="col-sm-3 control-label">描述（中文名）:</label>
                <div class="col-sm-2">
                    <input type="text" class="form-control" name="rDesc" id="rDesc" value="${role.rDesc}">
                </div>
            </div>
            <div class="form-group">
                <label for="add_permission" class="col-sm-3 control-label">权限:</label>
                <div id="add_permission" class="col-sm-9 text-left">
                    <c:if test="${option!='add'}">
                        <c:forEach items="${resources}" var="resource">
                        <span onclick="$(this).remove();">
                            <input type="checkbox" class="form-control" checked="checked" title="${resource.rName}"
                                   name="permission" value="${resource.id}">
                            <div class="layui-unselect layui-form-checkbox layui-form-checked"
                                 lay-skin=""><span>${resource.rName}</span><i
                                    class="layui-icon"></i></div>
                        </span>
                        </c:forEach>
                    </c:if>

                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-12">
                    <c:if test="${option=='add'}">
                        <button type="button" class="btn btn-default" onclick="add();">添加</button>
                    </c:if>
                    <c:if test="${option=='edit'}">
                        <button type="button" class="btn btn-default" onclick="edit();">修改</button>
                    </c:if>
                </div>

            </div>
            <input type="hidden" name="id" value="${role.id}">
        </form>
    </div>
</div>
</body>

</html>
