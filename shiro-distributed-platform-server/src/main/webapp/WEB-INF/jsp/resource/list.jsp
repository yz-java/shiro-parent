<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: yangzhao
  Date: 17/12/15
  Time: 16:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="../main.jsp" %>
    <title>资源列表</title>
    <script type="application/javascript">
        var layer;
        layui.use('layer', function () {
            layer = layui.layer;
        })

        function disable(areaId, status) {
            var updateChildStatus = 0;
            //询问框
            layer.confirm('是否禁用所有下级？', {
                btn: ['是', '否'], //按钮
                offset:'100px'
            }, function () {
                updateChildStatus = 1
                editOrgStatus(areaId, status, updateChildStatus);
            }, function () {
                layer.closeAll();
                editOrgStatus(areaId, status, updateChildStatus);
            });

        }
        function use(areaId, status) {
            var updateChildStatus = 0;
            //询问框
            layer.confirm('是否启用所有下级？', {
                btn: ['是', '否'], //按钮
                offset:'100px'
            }, function () {
                updateChildStatus = 1
                layer.closeAll();
                editOrgStatus(areaId, status, updateChildStatus);

            }, function () {
                layer.closeAll();
                editOrgStatus(areaId, status, updateChildStatus);
            });

        }
        function editOrgStatus(areaId, status, updateChildStatus) {
            $.post('/resource/edit/update_status', {
                'id': areaId,
                'status': status,
                'updateAllChild': updateChildStatus
            }, function (data) {
                if (data) {
                    layer.msg("操作成功")
                    window.location.reload();
                } else {
                    layer.msg("操作失败")
                }
            })
        }
    </script>
</head>
<body>
<div class="container-fluid">
    <ul id="myTab" class="nav nav-tabs">
        <li class="active"><a href="#organization" data-toggle="tab">资源列表</a></li>
        <li onclick="location.href='/resource/0/add'"><a href="#" data-toggle="tab">资源添加</a></li>
    </ul>
    <div id="myTabContent" class="tab-content">
        <div class="tab-pane fade in active" id="organization">
            <div class="table-bordered" style="padding: 20px">
                <form class="form-inline layui-form layui-form-pane1" action="/resource/search">
                    <div class="form-group">
                        <label for="id">资源ID</label>
                        <input type="text" name="id" class="form-control" id="id">
                    </div>
                    <div class="form-group">
                        <label for="rName">资源名称</label>
                        <input type="text" name="rName" class="form-control" id="rName">
                    </div>
                    <div class="form-group">
                        <label for="rType">资源类型</label>
                        <select name="rType" id="rType" class="form-control">
                            <option value="0">请选择</option>
                            <option value="1">菜单</option>
                            <option value="2">按钮</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-default">搜索</button>
                </form>
            </div>
            <div class="table-responsive">
                <table class="table text-nowrap table-bordered">
                    <thead>
                    <tr>
                        <td>资源ID</td>
                        <td>资源名称</td>
                        <td>资源URL</td>
                        <td>资源类型</td>
                        <td>父节点</td>
                        <td>权限</td>
                        <td>状态</td>
                        <td>操作</td>
                    </tr>
                    </thead>
                    <tbody>

                    <c:if test="${empty resources}">
                        <tr>
                            <td colspan="20">暂无数据</td>
                        </tr>
                    </c:if>

                    <c:forEach items="${resources}" var="resource">
                        <tr>
                            <td>${resource.id}</td>
                            <td>${resource.rName}</td>
                            <td>${resource.url}</td>
                            <td>
                                <c:if test="${resource.rType==1}">
                                    菜单
                                </c:if>
                                <c:if test="${resource.rType==2}">
                                    按钮
                                </c:if>
                            </td>
                            <td>${resource.parentId}</td>
                            <td>${resource.permission}</td>
                            <td>
                                    ${resource.rStatus}
                            </td>
                            <td>
                                <a href="/resource/${resource.id}/edit">修改</a>
                                <c:if test="${resource.rStatus==false}">
                                    <a href="#" onclick="use('${resource.id}',1);">启用</a>
                                </c:if>
                                <c:if test="${resource.rStatus==true}">
                                    <a href="#" onclick="disable('${resource.id}',0)">禁用</a>
                                </c:if>
                                <a href="/resource/${resource.id}/add">添加下级机构</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
